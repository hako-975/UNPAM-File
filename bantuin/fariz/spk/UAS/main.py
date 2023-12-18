
from http import HTTPStatus
from flask import Flask, request, abort
from flask_restful import Resource, Api 
from models import Printer as PrinterModel
from engine import engine
from sqlalchemy import select
from sqlalchemy.orm import Session

session = Session(engine)

app = Flask(__name__)
api = Api(app)        

class BaseMethod():

    def __init__(self):
        self.raw_weight = {'kecepatan_cetak': 3, 'kualitas_cetak': 5, 'koneksi': 3, 'harga': 5, 'berat': 2}

    @property
    def weight(self):
        total_weight = sum(self.raw_weight.values())
        return {k: round(v/total_weight, 2) for k, v in self.raw_weight.items()}

    @property
    def data(self):
        query = select(PrinterModel.id_printer, PrinterModel.kecepatan_cetak, PrinterModel.kualitas_cetak, PrinterModel.koneksi, PrinterModel.harga, PrinterModel.berat)
        result = session.execute(query).fetchall()
        print(result)
        return [{'id_printer': printer.id_printer, 'kecepatan_cetak': printer.kecepatan_cetak, 'kualitas_cetak': printer.kualitas_cetak, 'koneksi': printer.koneksi, 'harga': printer.harga, 'berat': printer.berat} for printer in result]

    @property
    def normalized_data(self):
        kecepatan_cetak_values = []
        kualitas_cetak_values = []
        koneksi_values = []
        harga_values = []
        berat_values = []

        for data in self.data:
            kecepatan_cetak_values.append(data['kecepatan_cetak'])
            kualitas_cetak_values.append(data['kualitas_cetak'])
            koneksi_values.append(data['koneksi'])
            harga_values.append(data['harga'])
            berat_values.append(data['berat'])

        return [
            {'id_printer': data['id_printer'],
             'kecepatan_cetak': data['kecepatan_cetak'] / max(kecepatan_cetak_values),
             'kualitas_cetak': data['kualitas_cetak'] / max(kualitas_cetak_values),
             'koneksi': data['koneksi'] / max(koneksi_values),
             'harga': min(harga_values) / data['harga'],
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
                row['kecepatan_cetak'] ** self.raw_weight['kecepatan_cetak'] *
                row['kualitas_cetak'] ** self.raw_weight['kualitas_cetak'] *
                row['koneksi'] ** self.raw_weight['koneksi'] *
                row['harga'] ** self.raw_weight['harga'] *
                row['berat'] ** self.raw_weight['berat']
            )

            produk.append({
                'id_printer': row['id_printer'],
                'produk': product_score
            })

        sorted_produk = sorted(produk, key=lambda x: x['produk'], reverse=True)

        sorted_data = []

        for product in sorted_produk:
            sorted_data.append({
                'id_printer': product['id_printer'],
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
        result = {row['id_printer']:
                  round(row['kecepatan_cetak'] * weight['kecepatan_cetak'] +
                        row['kualitas_cetak'] * weight['kualitas_cetak'] +
                        row['koneksi'] * weight['koneksi'] +
                        row['harga'] * weight['harga'] +
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


class Printer(Resource):
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
        query = select(PrinterModel)
        data = [{'id_printer': printer.id_printer, 'kecepatan_cetak': printer.kecepatan_cetak, 'kualitas_cetak': printer.kualitas_cetak, 'koneksi': printer.koneksi, 'harga': printer.harga, 'berat': printer.berat} for printer in session.scalars(query)]
        return self.get_paginated_result('printer/', data, request.args), HTTPStatus.OK.value


api.add_resource(Printer, '/printer')
api.add_resource(WeightedProduct, '/wp')
api.add_resource(SimpleAdditiveWeighting, '/saw')

if __name__ == '__main__':
    app.run(port='5005', debug=True)
