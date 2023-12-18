from http import HTTPStatus
from flask import Flask, request, abort
from flask_restful import Resource, Api 
from models import Monitor as MonitorModel
from engine import engine
from sqlalchemy import select
from sqlalchemy.orm import Session

session = Session(engine)

app = Flask(__name__)
api = Api(app)        

class BaseMethod():

    def __init__(self):
        self.raw_weight = {'harga': 3, 'ukuran_layar': 5, 'resolusi': 3, 'refresh_rate': 5, 'garansi': 2}

    @property
    def weight(self):
        total_weight = sum(self.raw_weight.values())
        return {k: round(v/total_weight, 2) for k, v in self.raw_weight.items()}

    @property
    def data(self):
        query = select(MonitorModel.id_monitor, MonitorModel.harga, MonitorModel.ukuran_layar, MonitorModel.resolusi, MonitorModel.refresh_rate, MonitorModel.garansi)
        result = session.execute(query).fetchall()
        print(result)
        return [{'id_monitor': monitor.id_monitor, 'harga': monitor.harga, 'ukuran_layar': monitor.ukuran_layar, 'resolusi': monitor.resolusi, 'refresh_rate': monitor.refresh_rate, 'garansi': monitor.garansi} for monitor in result]

    @property
    def normalized_data(self):
        harga_values = []
        ukuran_layar_values = []
        resolusi_values = []
        refresh_rate_values = []
        garansi_values = []

        for data in self.data:
            harga_values.append(data['harga'])
            ukuran_layar_values.append(data['ukuran_layar'])
            resolusi_values.append(data['resolusi'])
            refresh_rate_values.append(data['refresh_rate'])
            garansi_values.append(data['garansi'])

        return [
            {'id_monitor': data['id_monitor'],
             'harga': min(harga_values) / data['harga'],
             'ukuran_layar': data['ukuran_layar'] / max(ukuran_layar_values),
             'resolusi': data['resolusi'] / max(resolusi_values),
             'refresh_rate': data['refresh_rate'] / max(refresh_rate_values),
             'garansi': data['garansi'] / max(garansi_values)
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
                row['ukuran_layar'] ** self.raw_weight['ukuran_layar'] *
                row['resolusi'] ** self.raw_weight['resolusi'] *
                row['refresh_rate'] ** self.raw_weight['refresh_rate'] *
                row['garansi'] ** self.raw_weight['garansi']
            )

            produk.append({
                'id_monitor': row['id_monitor'],
                'produk': product_score
            })

        sorted_produk = sorted(produk, key=lambda x: x['produk'], reverse=True)

        sorted_data = []

        for product in sorted_produk:
            sorted_data.append({
                'id_monitor': product['id_monitor'],
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
        result = {row['id_monitor']:
                  round(row['harga'] * weight['harga'] +
                        row['ukuran_layar'] * weight['ukuran_layar'] +
                        row['resolusi'] * weight['resolusi'] +
                        row['refresh_rate'] * weight['refresh_rate'] +
                        row['garansi'] * weight['garansi'], 2)
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


class Monitor(Resource):
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
        query = select(MonitorModel)
        data = [{'id_monitor': monitor.id_monitor, 'harga': monitor.harga, 'ukuran_layar': monitor.ukuran_layar, 'resolusi': monitor.resolusi, 'refresh_rate': monitor.refresh_rate, 'garansi': monitor.garansi} for monitor in session.scalars(query)]
        return self.get_paginated_result('monitor/', data, request.args), HTTPStatus.OK.value


api.add_resource(Monitor, '/monitor')
api.add_resource(WeightedProduct, '/wp')
api.add_resource(SimpleAdditiveWeighting, '/saw')

if __name__ == '__main__':
    app.run(port='5005', debug=True)
