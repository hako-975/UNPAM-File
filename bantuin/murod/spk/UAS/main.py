from http import HTTPStatus
from flask import Flask, request, abort
from flask_restful import Resource, Api 
from models import Baju as BajuModel
from engine import engine
from sqlalchemy import select
from sqlalchemy.orm import Session

session = Session(engine)

app = Flask(__name__)
api = Api(app)        

class BaseMethod():

    def __init__(self):
        self.raw_weight = {'harga': 3, 'kenyamanan': 5, 'ulasan': 3, 'kualitas_warna': 5, 'desain': 2}

    @property
    def weight(self):
        total_weight = sum(self.raw_weight.values())
        return {k: round(v/total_weight, 2) for k, v in self.raw_weight.items()}

    @property
    def data(self):
        query = select(BajuModel.id_baju, BajuModel.harga, BajuModel.kenyamanan, BajuModel.ulasan, BajuModel.kualitas_warna, BajuModel.desain)
        result = session.execute(query).fetchall()
        print(result)
        return [{'id_baju': baju.id_baju, 'harga': baju.harga, 'kenyamanan': baju.kenyamanan, 'ulasan': baju.ulasan, 'kualitas_warna': baju.kualitas_warna, 'desain': baju.desain} for baju in result]

    @property
    def normalized_data(self):
        harga_values = []
        kenyamanan_values = []
        ulasan_values = []
        kualitas_warna_values = []
        desain_values = []

        for data in self.data:
            harga_values.append(data['harga'])
            kenyamanan_values.append(data['kenyamanan'])
            ulasan_values.append(data['ulasan'])
            kualitas_warna_values.append(data['kualitas_warna'])
            desain_values.append(data['desain'])

        return [
            {'id_baju': data['id_baju'],
             'harga': min(harga_values) / data['harga'],
             'kenyamanan': data['kenyamanan'] / max(kenyamanan_values),
             'ulasan': data['ulasan'] / max(ulasan_values),
             'kualitas_warna': data['kualitas_warna'] / max(kualitas_warna_values),
             'desain': data['desain'] / max(desain_values)
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
                row['kenyamanan'] ** self.raw_weight['kenyamanan'] *
                row['ulasan'] ** self.raw_weight['ulasan'] *
                row['kualitas_warna'] ** self.raw_weight['kualitas_warna'] *
                row['desain'] ** self.raw_weight['desain']
            )

            produk.append({
                'id_baju': row['id_baju'],
                'produk': product_score
            })

        sorted_produk = sorted(produk, key=lambda x: x['produk'], reverse=True)

        sorted_data = []

        for product in sorted_produk:
            sorted_data.append({
                'id_baju': product['id_baju'],
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
        result = {row['id_baju']:
                  round(row['harga'] * weight['harga'] +
                        row['kenyamanan'] * weight['kenyamanan'] +
                        row['ulasan'] * weight['ulasan'] +
                        row['kualitas_warna'] * weight['kualitas_warna'] +
                        row['desain'] * weight['desain'], 2)
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


class Baju(Resource):
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
        query = select(BajuModel)
        data = [{'id_baju': baju.id_baju, 'harga': baju.harga, 'kenyamanan': baju.kenyamanan, 'ulasan': baju.ulasan, 'kualitas_warna': baju.kualitas_warna, 'desain': baju.desain} for baju in session.scalars(query)]
        return self.get_paginated_result('baju/', data, request.args), HTTPStatus.OK.value


api.add_resource(Baju, '/baju')
api.add_resource(WeightedProduct, '/wp')
api.add_resource(SimpleAdditiveWeighting, '/saw')

if __name__ == '__main__':
    app.run(port='5005', debug=True)
