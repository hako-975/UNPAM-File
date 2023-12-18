from http import HTTPStatus
from flask import Flask, request, abort
from flask_restful import Resource, Api 
from models import Kosmetik as KosmetikModel
from engine import engine
from sqlalchemy import select
from sqlalchemy.orm import Session

session = Session(engine)

app = Flask(__name__)
api = Api(app)        

class BaseMethod():

    def __init__(self):
        self.raw_weight = {'daya_tahan': 5, 'rating': 4, 'jenis_kulit': 3, 'harga': 4, 'kandungan': 4}

    @property
    def weight(self):
        total_weight = sum(self.raw_weight.values())
        return {k: round(v/total_weight, 2) for k, v in self.raw_weight.items()}

    @property
    def data(self):
        query = select(KosmetikModel.id_kosmetik, KosmetikModel.daya_tahan, KosmetikModel.rating, KosmetikModel.jenis_kulit, KosmetikModel.harga, KosmetikModel.kandungan)
        result = session.execute(query).fetchall()
        print(result)
        return [{'id_kosmetik': kosmetik.id_kosmetik, 'daya_tahan': kosmetik.daya_tahan, 'rating': kosmetik.rating, 'jenis_kulit': kosmetik.jenis_kulit, 'harga': kosmetik.harga, 'kandungan': kosmetik.kandungan} for kosmetik in result]

    @property
    def normalized_data(self):
        daya_tahan_values = []
        rating_values = []
        jenis_kulit_values = []
        harga_values = []
        kandungan_values = []

        for data in self.data:
            daya_tahan_values.append(data['daya_tahan'])
            rating_values.append(data['rating'])
            jenis_kulit_values.append(data['jenis_kulit'])
            harga_values.append(data['harga'])
            kandungan_values.append(data['kandungan'])

        return [
            {'id_kosmetik': data['id_kosmetik'],
             'daya_tahan': min(daya_tahan_values) / data['daya_tahan'],
             'rating': min(rating_values) / data['rating'],
             'jenis_kulit': data['jenis_kulit'] / max(jenis_kulit_values),
             'harga': data['harga'] / max(harga_values),
             'kandungan': data['kandungan'] / max(kandungan_values)
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
                row['daya_tahan'] ** self.raw_weight['daya_tahan'] *
                row['rating'] ** self.raw_weight['rating'] *
                row['jenis_kulit'] ** self.raw_weight['jenis_kulit'] *
                row['harga'] ** self.raw_weight['harga'] *
                row['kandungan'] ** self.raw_weight['kandungan']
            )

            produk.append({
                'id_kosmetik': row['id_kosmetik'],
                'produk': product_score
            })

        sorted_produk = sorted(produk, key=lambda x: x['produk'], reverse=True)

        sorted_data = []

        for product in sorted_produk:
            sorted_data.append({
                'id_kosmetik': product['id_kosmetik'],
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
        result = {row['id_kosmetik']:
                  round(row['daya_tahan'] * weight['daya_tahan'] +
                        row['rating'] * weight['rating'] +
                        row['jenis_kulit'] * weight['jenis_kulit'] +
                        row['harga'] * weight['harga'] +
                        row['kandungan'] * weight['kandungan'], 2)
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


class Kosmetik(Resource):
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
        query = select(KosmetikModel)
        data = [{'id_kosmetik': kosmetik.id_kosmetik, 'daya_tahan': kosmetik.daya_tahan, 'rating': kosmetik.rating, 'jenis_kulit': kosmetik.jenis_kulit, 'harga': kosmetik.harga, 'kandungan': kosmetik.kandungan} for kosmetik in session.scalars(query)]
        return self.get_paginated_result('kosmetik/', data, request.args), HTTPStatus.OK.value


api.add_resource(Kosmetik, '/kosmetik')
api.add_resource(WeightedProduct, '/wp')
api.add_resource(SimpleAdditiveWeighting, '/saw')

if __name__ == '__main__':
    app.run(port='5005', debug=True)
