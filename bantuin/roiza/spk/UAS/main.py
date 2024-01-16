from http import HTTPStatus
from flask import Flask, request, abort
from flask_restful import Resource, Api 
from models import HelmMotor as HelmMotorModel
from engine import engine
from sqlalchemy import select
from sqlalchemy.orm import Session

session = Session(engine)

app = Flask(__name__)
api = Api(app)        

class BaseMethod():

    def __init__(self):
        self.raw_weight = {'harga': 8, 'rating': 7, 'berat': 6, 'tingkat_keamanan': 9, 'ventilasi': 6}

    @property
    def weight(self):
        total_weight = sum(self.raw_weight.values())
        return {k: round(v/total_weight, 2) for k, v in self.raw_weight.items()}

    @property
    def data(self):
        query = select(HelmMotorModel.id_helm_motor, HelmMotorModel.harga, HelmMotorModel.rating, HelmMotorModel.berat, HelmMotorModel.tingkat_keamanan, HelmMotorModel.ventilasi)
        result = session.execute(query).fetchall()
        print(result)
        return [{'id_helm_motor': helm_motor.id_helm_motor, 'harga': helm_motor.harga, 'rating': helm_motor.rating, 'berat': helm_motor.berat, 'tingkat_keamanan': helm_motor.tingkat_keamanan, 'ventilasi': helm_motor.ventilasi} for helm_motor in result]

    @property
    def normalized_data(self):
        harga_values = []
        rating_values = []
        berat_values = []
        tingkat_keamanan_values = []
        ventilasi_values = []

        for data in self.data:
            harga_values.append(data['harga'])
            rating_values.append(data['rating'])
            berat_values.append(data['berat'])
            tingkat_keamanan_values.append(data['tingkat_keamanan'])
            ventilasi_values.append(data['ventilasi'])

        return [
            {'id_helm_motor': data['id_helm_motor'],
             'harga': min(harga_values) / data['harga'],
             'rating': data['rating'] / max(rating_values),
             'berat': data['berat'] / max(berat_values),
             'tingkat_keamanan': data['tingkat_keamanan'] / max(tingkat_keamanan_values),
             'ventilasi': data['ventilasi'] / max(ventilasi_values)
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
                row['berat'] ** self.raw_weight['berat'] *
                row['tingkat_keamanan'] ** self.raw_weight['tingkat_keamanan'] *
                row['ventilasi'] ** self.raw_weight['ventilasi']
            )

            produk.append({
                'id_helm_motor': row['id_helm_motor'],
                'produk': product_score
            })

        sorted_produk = sorted(produk, key=lambda x: x['produk'], reverse=True)

        sorted_data = []

        for product in sorted_produk:
            sorted_data.append({
                'id_helm_motor': product['id_helm_motor'],
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
        result = {row['id_helm_motor']:
                  round(row['harga'] * weight['harga'] +
                        row['rating'] * weight['rating'] +
                        row['berat'] * weight['berat'] +
                        row['tingkat_keamanan'] * weight['tingkat_keamanan'] +
                        row['ventilasi'] * weight['ventilasi'], 2)
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


class HelmMotor(Resource):
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
        query = select(HelmMotorModel)
        data = [{'id_helm_motor': helm_motor.id_helm_motor, 'harga': helm_motor.harga, 'rating': helm_motor.rating, 'berat': helm_motor.berat, 'tingkat_keamanan': helm_motor.tingkat_keamanan, 'ventilasi': helm_motor.ventilasi} for helm_motor in session.scalars(query)]
        return self.get_paginated_result('helm_motor/', data, request.args), HTTPStatus.OK.value


api.add_resource(HelmMotor, '/helm_motor')
api.add_resource(WeightedProduct, '/wp')
api.add_resource(SimpleAdditiveWeighting, '/saw')

if __name__ == '__main__':
    app.run(port='5005', debug=True)
