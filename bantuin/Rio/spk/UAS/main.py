from http import HTTPStatus
from flask import Flask, request, abort
from flask_restful import Resource, Api 
from models import JamTangan as JamTanganModel
from engine import engine
from sqlalchemy import select
from sqlalchemy.orm import Session

session = Session(engine)

app = Flask(__name__)
api = Api(app)        

class BaseMethod():

    def __init__(self):
        self.raw_weight = {'harga': 3, 'rating': 5, 'baterai': 3, 'kedalaman_tahan_air': 5, 'berat': 2}

    @property
    def weight(self):
        total_weight = sum(self.raw_weight.values())
        return {k: round(v/total_weight, 2) for k, v in self.raw_weight.items()}

    @property
    def data(self):
        query = select(JamTanganModel.id_jam_tangan, JamTanganModel.harga, JamTanganModel.rating, JamTanganModel.baterai, JamTanganModel.kedalaman_tahan_air, JamTanganModel.berat)
        result = session.execute(query).fetchall()
        print(result)
        return [{'id_jam_tangan': jam_tangan.id_jam_tangan, 'harga': jam_tangan.harga, 'rating': jam_tangan.rating, 'baterai': jam_tangan.baterai, 'kedalaman_tahan_air': jam_tangan.kedalaman_tahan_air, 'berat': jam_tangan.berat} for jam_tangan in result]

    @property
    def normalized_data(self):
        harga_values = []
        rating_values = []
        baterai_values = []
        kedalaman_tahan_air_values = []
        berat_values = []

        for data in self.data:
            harga_values.append(data['harga'])
            rating_values.append(data['rating'])
            baterai_values.append(data['baterai'])
            kedalaman_tahan_air_values.append(data['kedalaman_tahan_air'])
            berat_values.append(data['berat'])

        return [
            {'id_jam_tangan': data['id_jam_tangan'],
             'harga': min(harga_values) / data['harga'],
             'rating': data['rating'] / max(rating_values),
             'baterai': data['baterai'] / max(baterai_values),
             'kedalaman_tahan_air': data['kedalaman_tahan_air'] / max(kedalaman_tahan_air_values),
             'berat': min(berat_values) / data['berat']
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
                row['rating'] ** self.raw_weight['rating'] *
                row['baterai'] ** self.raw_weight['baterai'] *
                row['kedalaman_tahan_air'] ** self.raw_weight['kedalaman_tahan_air'] *
                row['berat'] ** self.raw_weight['berat']
            )

            produk.append({
                'id_jam_tangan': row['id_jam_tangan'],
                'produk': product_score
            })

        sorted_produk = sorted(produk, key=lambda x: x['produk'], reverse=True)

        sorted_data = []

        for product in sorted_produk:
            sorted_data.append({
                'id_jam_tangan': product['id_jam_tangan'],
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
        result = {row['id_jam_tangan']:
                  round(row['harga'] * weight['harga'] +
                        row['rating'] * weight['rating'] +
                        row['baterai'] * weight['baterai'] +
                        row['kedalaman_tahan_air'] * weight['kedalaman_tahan_air'] +
                        row['berat'] * weight['berat'], 2)
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


class JamTangan(Resource):
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
        query = select(JamTanganModel)
        data = [{'id_jam_tangan': jam_tangan.id_jam_tangan, 'harga': jam_tangan.harga, 'rating': jam_tangan.rating, 'baterai': jam_tangan.baterai, 'kedalaman_tahan_air': jam_tangan.kedalaman_tahan_air, 'berat': jam_tangan.berat} for jam_tangan in session.scalars(query)]
        return self.get_paginated_result('jam_tangan/', data, request.args), HTTPStatus.OK.value


api.add_resource(JamTangan, '/jam_tangan')
api.add_resource(WeightedProduct, '/wp')
api.add_resource(SimpleAdditiveWeighting, '/saw')

if __name__ == '__main__':
    app.run(port='5005', debug=True)
