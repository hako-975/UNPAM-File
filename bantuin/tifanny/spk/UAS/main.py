from http import HTTPStatus
from flask import Flask, request, abort
from flask_restful import Resource, Api 
from models import Mahasiswa as MahasiswaModel
from engine import engine
from sqlalchemy import select
from sqlalchemy.orm import Session

session = Session(engine)

app = Flask(__name__)
api = Api(app)        

class BaseMethod():

    def __init__(self):
        self.raw_weight = {'prestasi': 3, 'ekstrakurikuler': 1, 'rekomendasi_dosen': 2, 'rencana_studi': 1, 'tes_kualifikasi': 3}

    @property
    def weight(self):
        total_weight = sum(self.raw_weight.values())
        return {k: round(v/total_weight, 2) for k, v in self.raw_weight.items()}

    @property
    def data(self):
        query = select(MahasiswaModel.id_mahasiswa, MahasiswaModel.prestasi, MahasiswaModel.ekstrakurikuler, MahasiswaModel.rekomendasi_dosen, MahasiswaModel.rencana_studi, MahasiswaModel.tes_kualifikasi)
        result = session.execute(query).fetchall()
        print(result)
        return [{'id_mahasiswa': mahasiswa.id_mahasiswa, 'prestasi': mahasiswa.prestasi, 'ekstrakurikuler': mahasiswa.ekstrakurikuler, 'rekomendasi_dosen': mahasiswa.rekomendasi_dosen, 'rencana_studi': mahasiswa.rencana_studi, 'tes_kualifikasi': mahasiswa.tes_kualifikasi} for mahasiswa in result]

    @property
    def normalized_data(self):
        prestasi_values = []
        ekstrakurikuler_values = []
        rekomendasi_dosen_values = []
        rencana_studi_values = []
        tes_kualifikasi_values = []

        for data in self.data:
            prestasi_values.append(data['prestasi'])
            ekstrakurikuler_values.append(data['ekstrakurikuler'])
            rekomendasi_dosen_values.append(data['rekomendasi_dosen'])
            rencana_studi_values.append(data['rencana_studi'])
            tes_kualifikasi_values.append(data['tes_kualifikasi'])

        return [
            {'id_mahasiswa': data['id_mahasiswa'],
             'prestasi': min(prestasi_values) / data['prestasi'],
             'ekstrakurikuler': min(ekstrakurikuler_values) / data['ekstrakurikuler'],
             'rekomendasi_dosen': data['rekomendasi_dosen'] / max(rekomendasi_dosen_values),
             'rencana_studi': data['rencana_studi'] / max(rencana_studi_values),
             'tes_kualifikasi': data['tes_kualifikasi'] / max(tes_kualifikasi_values)
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
                row['prestasi'] ** self.raw_weight['prestasi'] *
                row['ekstrakurikuler'] ** self.raw_weight['ekstrakurikuler'] *
                row['rekomendasi_dosen'] ** self.raw_weight['rekomendasi_dosen'] *
                row['rencana_studi'] ** self.raw_weight['rencana_studi'] *
                row['tes_kualifikasi'] ** self.raw_weight['tes_kualifikasi']
            )

            produk.append({
                'id_mahasiswa': row['id_mahasiswa'],
                'produk': product_score
            })

        sorted_produk = sorted(produk, key=lambda x: x['produk'], reverse=True)

        sorted_data = []

        for product in sorted_produk:
            sorted_data.append({
                'id_mahasiswa': product['id_mahasiswa'],
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
        result = {row['id_mahasiswa']:
                  round(row['prestasi'] * weight['prestasi'] +
                        row['ekstrakurikuler'] * weight['ekstrakurikuler'] +
                        row['rekomendasi_dosen'] * weight['rekomendasi_dosen'] +
                        row['rencana_studi'] * weight['rencana_studi'] +
                        row['tes_kualifikasi'] * weight['tes_kualifikasi'], 2)
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


class Mahasiswa(Resource):
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
        query = select(MahasiswaModel)
        data = [{'id_mahasiswa': mahasiswa.id_mahasiswa, 'prestasi': mahasiswa.prestasi, 'ekstrakurikuler': mahasiswa.ekstrakurikuler, 'rekomendasi_dosen': mahasiswa.rekomendasi_dosen, 'rencana_studi': mahasiswa.rencana_studi, 'tes_kualifikasi': mahasiswa.tes_kualifikasi} for mahasiswa in session.scalars(query)]
        return self.get_paginated_result('mahasiswa/', data, request.args), HTTPStatus.OK.value


api.add_resource(Mahasiswa, '/mahasiswa')
api.add_resource(WeightedProduct, '/wp')
api.add_resource(SimpleAdditiveWeighting, '/saw')

if __name__ == '__main__':
    app.run(port='5005', debug=True)
