from http import HTTPStatus
from flask import Flask, request, abort
from flask_restful import Resource, Api 
from models import Motor as MotorModel
from engine import engine
from sqlalchemy import select
from sqlalchemy.orm import Session

session = Session(engine)

app = Flask(__name__)
api = Api(app)        

class BaseMethod():

    def __init__(self):
        self.raw_weight = {'harga': 3, 'kecepatan_maksimum': 2, 'konsumsi_bahan_bakar': 2, 'ukuran_mesin': 3, 'ulasan': 3}

    @property
    def weight(self):
        total_weight = sum(self.raw_weight.values())
        return {k: round(v/total_weight, 2) for k, v in self.raw_weight.items()}

    @property
    def data(self):
        query = select(MotorModel.id_motor, MotorModel.harga, MotorModel.kecepatan_maksimum, MotorModel.konsumsi_bahan_bakar, MotorModel.ukuran_mesin, MotorModel.ulasan)
        result = session.execute(query).fetchall()
        print(result)
        return [{'id_motor': motor.id_motor, 'harga': motor.harga, 'kecepatan_maksimum': motor.kecepatan_maksimum, 'konsumsi_bahan_bakar': motor.konsumsi_bahan_bakar, 'ukuran_mesin': motor.ukuran_mesin, 'ulasan': motor.ulasan} for motor in result]

    @property
    def normalized_data(self):
        harga_values = []
        kecepatan_maksimum_values = []
        konsumsi_bahan_bakar_values = []
        ukuran_mesin_values = []
        ulasan_values = []

        for data in self.data:
            harga_values.append(data['harga'])
            kecepatan_maksimum_values.append(data['kecepatan_maksimum'])
            konsumsi_bahan_bakar_values.append(data['konsumsi_bahan_bakar'])
            ukuran_mesin_values.append(data['ukuran_mesin'])
            ulasan_values.append(data['ulasan'])

        return [
            {'id_motor': data['id_motor'],
             'harga': min(harga_values) / data['harga'],
             'kecepatan_maksimum': min(kecepatan_maksimum_values) / data['kecepatan_maksimum'],
             'konsumsi_bahan_bakar': data['konsumsi_bahan_bakar'] / max(konsumsi_bahan_bakar_values),
             'ukuran_mesin': data['ukuran_mesin'] / max(ukuran_mesin_values),
             'ulasan': data['ulasan'] / max(ulasan_values)
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
                row['kecepatan_maksimum'] ** self.raw_weight['kecepatan_maksimum'] *
                row['konsumsi_bahan_bakar'] ** self.raw_weight['konsumsi_bahan_bakar'] *
                row['ukuran_mesin'] ** self.raw_weight['ukuran_mesin'] *
                row['ulasan'] ** self.raw_weight['ulasan']
            )

            produk.append({
                'id_motor': row['id_motor'],
                'produk': product_score
            })

        sorted_produk = sorted(produk, key=lambda x: x['produk'], reverse=True)

        sorted_data = []

        for product in sorted_produk:
            sorted_data.append({
                'id_motor': product['id_motor'],
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
        result = {row['id_motor']:
                  round(row['harga'] * weight['harga'] +
                        row['kecepatan_maksimum'] * weight['kecepatan_maksimum'] +
                        row['konsumsi_bahan_bakar'] * weight['konsumsi_bahan_bakar'] +
                        row['ukuran_mesin'] * weight['ukuran_mesin'] +
                        row['ulasan'] * weight['ulasan'], 2)
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


class Motor(Resource):
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
        query = select(MotorModel)
        data = [{'id_motor': motor.id_motor, 'harga': motor.harga, 'kecepatan_maksimum': motor.kecepatan_maksimum, 'konsumsi_bahan_bakar': motor.konsumsi_bahan_bakar, 'ukuran_mesin': motor.ukuran_mesin, 'ulasan': motor.ulasan} for motor in session.scalars(query)]
        return self.get_paginated_result('motor/', data, request.args), HTTPStatus.OK.value


api.add_resource(Motor, '/motor')
api.add_resource(WeightedProduct, '/wp')
api.add_resource(SimpleAdditiveWeighting, '/saw')

if __name__ == '__main__':
    app.run(port='5005', debug=True)
