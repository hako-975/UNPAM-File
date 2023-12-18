
from http import HTTPStatus
from flask import Flask, request, abort
from flask_restful import Resource, Api 
from models import Komputer as KomputerModel
from engine import engine
from sqlalchemy import select
from sqlalchemy.orm import Session
from tabulate import tabulate

session = Session(engine)

app = Flask(__name__)
api = Api(app)        

class BaseMethod():

    def __init__(self):
        self.raw_weight = {'harga': 5, 'berat': 3, 'rating': 4, 'garansi': 3, 'kecepatan_processor': 5}

    @property
    def weight(self):
        total_weight = sum(self.raw_weight.values())
        return {k: round(v/total_weight, 2) for k, v in self.raw_weight.items()}

    @property
    def data(self):
        query = select(KomputerModel.id_komputer, KomputerModel.harga, KomputerModel.berat, KomputerModel.rating, KomputerModel.garansi, KomputerModel.kecepatan_processor)
        result = session.execute(query).fetchall()
        print(result)
        return [{'id_komputer': komputer.id_komputer, 'harga': komputer.harga, 'berat': komputer.berat, 'rating': komputer.rating, 'garansi': komputer.garansi, 'kecepatan_processor': komputer.kecepatan_processor} for komputer in result]

    @property
    def normalized_data(self):
        harga_values = []
        berat_values = []
        rating_values = []
        garansi_values = []
        kecepatan_processor_values = []

        for data in self.data:
            harga_values.append(data['harga'])
            berat_values.append(data['berat'])
            rating_values.append(data['rating'])
            garansi_values.append(data['garansi'])
            kecepatan_processor_values.append(data['kecepatan_processor'])

        return [
            {'id_komputer': data['id_komputer'],
             'harga': min(harga_values) / data['harga'],
             'berat': min(berat_values) / data['berat'],
             'rating': data['rating'] / max(rating_values),
             'garansi': data['garansi'] / max(garansi_values),
             'kecepatan_processor': data['kecepatan_processor'] / max(kecepatan_processor_values)
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
                row['berat'] ** self.raw_weight['berat'] *
                row['rating'] ** self.raw_weight['rating'] *
                row['garansi'] ** self.raw_weight['garansi'] *
                row['kecepatan_processor'] ** self.raw_weight['kecepatan_processor']
            )

            produk.append({
                'id_komputer': row['id_komputer'],
                'produk': product_score
            })

        sorted_produk = sorted(produk, key=lambda x: x['produk'], reverse=True)

        sorted_data = []

        for product in sorted_produk:
            sorted_data.append({
                'id_komputer': product['id_komputer'],
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
        result = {row['id_komputer']:
                  round(row['harga'] * weight['harga'] +
                        row['berat'] * weight['berat'] +
                        row['rating'] * weight['rating'] +
                        row['garansi'] * weight['garansi'] +
                        row['kecepatan_processor'] * weight['kecepatan_processor'], 2)
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


class Komputer(Resource):
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
        query = select(KomputerModel)
        data = [{'id_komputer': komputer.id_komputer, 'harga': komputer.harga, 'berat': komputer.berat, 'rating': komputer.rating, 'garansi': komputer.garansi, 'kecepatan_processor': komputer.kecepatan_processor} for komputer in session.scalars(query)]
        return self.get_paginated_result('komputer/', data, request.args), HTTPStatus.OK.value


api.add_resource(Komputer, '/komputer')
api.add_resource(WeightedProduct, '/wp')
api.add_resource(SimpleAdditiveWeighting, '/saw')

if __name__ == '__main__':
    app.run(port='5005', debug=True)
