from http import HTTPStatus
from flask import Flask, request, abort
from flask_restful import Resource, Api 
from models import SikatGigi as SikatGigiModel
from engine import engine
from sqlalchemy import select
from sqlalchemy.orm import Session

session = Session(engine)

app = Flask(__name__)
api = Api(app)        

class BaseMethod():

    def __init__(self):
        self.raw_weight = {'harga': 4, 'kekerasan_bulu_sikat': 4, 'bahan_bulu_sikat': 3, 'ukuran_kepala_sikat': 4, 'ulasan': 5}

    @property
    def weight(self):
        total_weight = sum(self.raw_weight.values())
        return {k: round(v/total_weight, 2) for k, v in self.raw_weight.items()}

    @property
    def data(self):
        query = select(SikatGigiModel.id_sikat_gigi, SikatGigiModel.harga, SikatGigiModel.kekerasan_bulu_sikat, SikatGigiModel.bahan_bulu_sikat, SikatGigiModel.ukuran_kepala_sikat, SikatGigiModel.ulasan)
        result = session.execute(query).fetchall()
        print(result)
        return [{'id_sikat_gigi': sikat_gigi.id_sikat_gigi, 'harga': sikat_gigi.harga, 'kekerasan_bulu_sikat': sikat_gigi.kekerasan_bulu_sikat, 'bahan_bulu_sikat': sikat_gigi.bahan_bulu_sikat, 'ukuran_kepala_sikat': sikat_gigi.ukuran_kepala_sikat, 'ulasan': sikat_gigi.ulasan} for sikat_gigi in result]

    @property
    def normalized_data(self):
        harga_values = []
        kekerasan_bulu_sikat_values = []
        bahan_bulu_sikat_values = []
        ukuran_kepala_sikat_values = []
        ulasan_values = []

        for data in self.data:
            harga_values.append(data['harga'])
            kekerasan_bulu_sikat_values.append(data['kekerasan_bulu_sikat'])
            bahan_bulu_sikat_values.append(data['bahan_bulu_sikat'])
            ukuran_kepala_sikat_values.append(data['ukuran_kepala_sikat'])
            ulasan_values.append(data['ulasan'])

        return [
            {'id_sikat_gigi': data['id_sikat_gigi'],
             'harga': data['harga'] / max(harga_values),
             'kekerasan_bulu_sikat': data['kekerasan_bulu_sikat'] / max(kekerasan_bulu_sikat_values),
             'bahan_bulu_sikat': data['bahan_bulu_sikat'] / max(bahan_bulu_sikat_values),
             'ukuran_kepala_sikat': min(ukuran_kepala_sikat_values) / data['ukuran_kepala_sikat'],
             'ulasan': min(ulasan_values) / data['ulasan']
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
                row['kekerasan_bulu_sikat'] ** self.raw_weight['kekerasan_bulu_sikat'] *
                row['bahan_bulu_sikat'] ** self.raw_weight['bahan_bulu_sikat'] *
                row['ukuran_kepala_sikat'] ** self.raw_weight['ukuran_kepala_sikat'] *
                row['ulasan'] ** self.raw_weight['ulasan']
            )

            produk.append({
                'id_sikat_gigi': row['id_sikat_gigi'],
                'produk': product_score
            })

        sorted_produk = sorted(produk, key=lambda x: x['produk'], reverse=True)

        sorted_data = []

        for product in sorted_produk:
            sorted_data.append({
                'id_sikat_gigi': product['id_sikat_gigi'],
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
        result = {row['id_sikat_gigi']:
                  round(row['harga'] * weight['harga'] +
                        row['kekerasan_bulu_sikat'] * weight['kekerasan_bulu_sikat'] +
                        row['bahan_bulu_sikat'] * weight['bahan_bulu_sikat'] +
                        row['ukuran_kepala_sikat'] * weight['ukuran_kepala_sikat'] +
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


class SikatGigi(Resource):
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
        query = select(SikatGigiModel)
        data = [{'id_sikat_gigi': sikat_gigi.id_sikat_gigi, 'harga': sikat_gigi.harga, 'kekerasan_bulu_sikat': sikat_gigi.kekerasan_bulu_sikat, 'bahan_bulu_sikat': sikat_gigi.bahan_bulu_sikat, 'ukuran_kepala_sikat': sikat_gigi.ukuran_kepala_sikat, 'ulasan': sikat_gigi.ulasan} for sikat_gigi in session.scalars(query)]
        return self.get_paginated_result('sikat_gigi/', data, request.args), HTTPStatus.OK.value


api.add_resource(SikatGigi, '/sikat_gigi')
api.add_resource(WeightedProduct, '/wp')
api.add_resource(SimpleAdditiveWeighting, '/saw')

if __name__ == '__main__':
    app.run(port='5005', debug=True)
