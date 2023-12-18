from http import HTTPStatus
from flask import Flask, request, abort
from flask_restful import Resource, Api 
from models import Rumah as RumahModel
from engine import engine
from sqlalchemy import select
from sqlalchemy.orm import Session

session = Session(engine)

app = Flask(__name__)
api = Api(app)        

class BaseMethod():

    def __init__(self):
        self.raw_weight = {'harga': 5, 'lokasi': 3, 'luas_tanah': 4, 'luas_bangunan': 3, 'fasilitas': 5}

    @property
    def weight(self):
        total_weight = sum(self.raw_weight.values())
        return {k: round(v/total_weight, 2) for k, v in self.raw_weight.items()}

    @property
    def data(self):
        query = select(RumahModel.id_rumah, RumahModel.harga, RumahModel.lokasi, RumahModel.luas_tanah, RumahModel.luas_bangunan, RumahModel.fasilitas)
        result = session.execute(query).fetchall()
        print(result)
        return [{'id_rumah': rumah.id_rumah, 'harga': rumah.harga, 'lokasi': rumah.lokasi, 'luas_tanah': rumah.luas_tanah, 'luas_bangunan': rumah.luas_bangunan, 'fasilitas': rumah.fasilitas} for rumah in result]

    @property
    def normalized_data(self):
        harga_values = []
        lokasi_values = []
        luas_tanah_values = []
        luas_bangunan_values = []
        fasilitas_values = []

        for data in self.data:
            harga_values.append(data['harga'])
            lokasi_values.append(data['lokasi'])
            luas_tanah_values.append(data['luas_tanah'])
            luas_bangunan_values.append(data['luas_bangunan'])
            fasilitas_values.append(data['fasilitas'])

        return [
            {'id_rumah': data['id_rumah'],
             'harga': min(harga_values) / data['harga'],
             'lokasi': min(lokasi_values) / data['lokasi'],
             'luas_tanah': data['luas_tanah'] / max(luas_tanah_values),
             'luas_bangunan': data['luas_bangunan'] / max(luas_bangunan_values),
             'fasilitas': data['fasilitas'] / max(fasilitas_values)
             }
            for data in self.data
        ]

    def update_weights(self, new_weights):
        self.raw_weight = new_weights

class WeightedProductCalculator(BaseMethod):
    def update_weights(self, new_weights):
        self.raw_weight = new_weights

    @property
    def calculate(self):
        normalized_data = self.normalized_data
        produk = []

        for row in normalized_data:
            product_score = (
                row['harga'] ** self.raw_weight['harga'] *
                row['lokasi'] ** self.raw_weight['lokasi'] *
                row['luas_tanah'] ** self.raw_weight['luas_tanah'] *
                row['luas_bangunan'] ** self.raw_weight['luas_bangunan'] *
                row['fasilitas'] ** self.raw_weight['fasilitas']
            )

            produk.append({
                'id_rumah': row['id_rumah'],
                'produk': product_score
            })

        sorted_produk = sorted(produk, key=lambda x: x['produk'], reverse=True)

        sorted_data = []

        for product in sorted_produk:
            sorted_data.append({
                'id_rumah': product['id_rumah'],
                'score': product['produk']
            })

        return sorted_data


class WeightedProduct(Resource):
    def get(self):
        calculator = WeightedProductCalculator()
        result = calculator.calculate
        return result, HTTPStatus.OK.value
    
    def post(self):
        new_weights = request.get_json()
        calculator = WeightedProductCalculator()
        calculator.update_weights(new_weights)
        result = calculator.calculate
        return {'data': result}, HTTPStatus.OK.value
    

class SimpleAdditiveWeightingCalculator(BaseMethod):
    @property
    def calculate(self):
        weight = self.weight
        result = {row['id_rumah']:
                  round(row['harga'] * weight['harga'] +
                        row['lokasi'] * weight['lokasi'] +
                        row['luas_tanah'] * weight['luas_tanah'] +
                        row['luas_bangunan'] * weight['luas_bangunan'] +
                        row['fasilitas'] * weight['fasilitas'], 2)
                  for row in self.normalized_data
                  }
        sorted_result = dict(
            sorted(result.items(), key=lambda x: x[1], reverse=True))
        return sorted_result

    def update_weights(self, new_weights):
        self.raw_weight = new_weights

class SimpleAdditiveWeighting(Resource):
    def get(self):
        saw = SimpleAdditiveWeightingCalculator()
        result = saw.calculate
        return result, HTTPStatus.OK.value

    def post(self):
        new_weights = request.get_json()
        saw = SimpleAdditiveWeightingCalculator()
        saw.update_weights(new_weights)
        result = saw.calculate
        return {'data': result}, HTTPStatus.OK.value


class Rumah(Resource):
    def get_paginated_result(self, url, list, args):
        page_size = int(args.get('page_size', 10))
        page = int(args.get('page', 1))
        page_count = int((len(list) + page_size - 1) / page_size)
        start = (page - 1) * page_size
        end = min(start + page_size, len(list))

        if page < page_count:
            next_page = f'{url}?page={page+1}&page_size={page_size}'
        else:
            next_page = None
        if page > 1:
            prev_page = f'{url}?page={page-1}&page_size={page_size}'
        else:
            prev_page = None
        
        if page > page_count or page < 1:
            abort(404, description=f'Halaman {page} tidak ditemukan.') 
        return {
            'page': page, 
            'page_size': page_size,
            'next': next_page, 
            'prev': prev_page,
            'Results': list[start:end]
        }

    def get(self):
        query = select(RumahModel)
        data = [{'id_rumah': rumah.id_rumah, 'harga': rumah.harga, 'lokasi': rumah.lokasi, 'luas_tanah': rumah.luas_tanah, 'luas_bangunan': rumah.luas_bangunan, 'fasilitas': rumah.fasilitas} for rumah in session.scalars(query)]
        return self.get_paginated_result('rumah/', data, request.args), HTTPStatus.OK.value


api.add_resource(Rumah, '/rumah')
api.add_resource(WeightedProduct, '/wp')
api.add_resource(SimpleAdditiveWeighting, '/saw')

if __name__ == '__main__':
    app.run(port='5005', debug=True)
