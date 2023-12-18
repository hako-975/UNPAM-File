
from http import HTTPStatus
from flask import Flask, request, abort
from flask_restful import Resource, Api 
from models import MinyakRambut as MinyakRambutModel
from engine import engine
from sqlalchemy import select
from sqlalchemy.orm import Session

session = Session(engine)

app = Flask(__name__)
api = Api(app)        

class BaseMethod():

    def __init__(self):
        self.raw_weight = {'harga': 4, 'kualitas': 6, 'aroma': 3, 'kemasan': 4, 'ulasan': 3}

    @property
    def weight(self):
        total_weight = sum(self.raw_weight.values())
        return {k: round(v/total_weight, 2) for k, v in self.raw_weight.items()}

    @property
    def data(self):
        query = select(MinyakRambutModel.id_minyak_rambut, MinyakRambutModel.harga, MinyakRambutModel.kualitas, MinyakRambutModel.aroma, MinyakRambutModel.kemasan, MinyakRambutModel.ulasan)
        result = session.execute(query).fetchall()
        print(result)
        return [{'id_minyak_rambut': minyak_rambut.id_minyak_rambut, 'harga': minyak_rambut.harga, 'kualitas': minyak_rambut.kualitas, 'aroma': minyak_rambut.aroma, 'kemasan': minyak_rambut.kemasan, 'ulasan': minyak_rambut.ulasan} for minyak_rambut in result]

    @property
    def normalized_data(self):
        harga_values = []
        kualitas_values = []
        aroma_values = []
        kemasan_values = []
        ulasan_values = []

        for data in self.data:
            harga_values.append(data['harga'])
            kualitas_values.append(data['kualitas'])
            aroma_values.append(data['aroma'])
            kemasan_values.append(data['kemasan'])
            ulasan_values.append(data['ulasan'])

        return [
            {'id_minyak_rambut': data['id_minyak_rambut'],
             'harga': min(harga_values) / data['harga'],
             'kualitas': data['kualitas'] / max(kualitas_values),
			 'aroma': data['aroma'] / max(aroma_values),
             'kemasan': data['kemasan'] / max(kemasan_values),
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
                row['kualitas'] ** self.raw_weight['kualitas'] *
                row['aroma'] ** self.raw_weight['aroma'] *
                row['kemasan'] ** self.raw_weight['kemasan'] *
                row['ulasan'] ** self.raw_weight['ulasan']
            )

            produk.append({
                'id_minyak_rambut': row['id_minyak_rambut'],
                'produk': product_score
            })

        sorted_produk = sorted(produk, key=lambda x: x['produk'], reverse=True)

        sorted_data = []

        for product in sorted_produk:
            sorted_data.append({
                'id_minyak_rambut': product['id_minyak_rambut'],
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
        result = {row['id_minyak_rambut']:
                  round(row['harga'] * weight['harga'] +
                        row['kualitas'] * weight['kualitas'] +
                        row['aroma'] * weight['aroma'] +
                        row['kemasan'] * weight['kemasan'] +
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


class MinyakRambut(Resource):
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
        query = select(MinyakRambutModel)
        data = [{'id_minyak_rambut': minyak_rambut.id_minyak_rambut, 'harga': minyak_rambut.harga, 'kualitas': minyak_rambut.kualitas, 'aroma': minyak_rambut.aroma, 'kemasan': minyak_rambut.kemasan, 'ulasan': minyak_rambut.ulasan} for minyak_rambut in session.scalars(query)]
        return self.get_paginated_result('minyak_rambut/', data, request.args), HTTPStatus.OK.value


api.add_resource(MinyakRambut, '/minyak_rambut')
api.add_resource(WeightedProduct, '/wp')
api.add_resource(SimpleAdditiveWeighting, '/saw')

if __name__ == '__main__':
    app.run(port='5005', debug=True)
