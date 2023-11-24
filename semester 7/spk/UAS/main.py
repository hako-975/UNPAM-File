import sys
from colorama import Fore, Style
from models import Base, MobilePhone
from engine import engine

from sqlalchemy import select
from sqlalchemy.orm import Session

session = Session(engine)

def create_table():
    Base.metadata.create_all(engine)
    print(f'{Fore.GREEN}[Success]: {Style.RESET_ALL}Database has created!')

class BaseMethod:

    def __init__(self):
        self.raw_weight = {'harga': -4, 'kualitas_kamera': 3, 'kapasitas_baterai': 4, 'kinerja': 6, 'ukuran_layar': 3}

    @property
    def weight(self):
        total_weight = sum(self.raw_weight.values())
        return {k: round(v/total_weight, 2) for k, v in self.raw_weight.items()}

    @property
    def data(self):
        query = select(MobilePhone)
        return [{'id_ponsel': phone.id_ponsel, 'harga': phone.harga, 'kualitas_kamera': phone.kualitas_kamera,
                 'kapasitas_baterai': phone.kapasitas_baterai, 'kinerja': phone.kinerja, 'ukuran_layar': phone.ukuran_layar}
                for phone in session.scalars(query)]

    @property
    def normalized_data(self):
        data = self.data
        criteria = ['harga', 'kualitas_kamera', 'kapasitas_baterai', 'kinerja', 'ukuran_layar']

        for criterion in criteria:
            values = [item[criterion] for item in data]
            min_value = min(values)
            max_value = max(values)

            for item in data:
                item[criterion] = (item[criterion] - min_value) / (max_value - min_value) if max_value != min_value else 0

        return data

class WeightedProduct(BaseMethod):

    @property
    def calculate(self):
        weight = self.weight
        result = {row['id_ponsel']:
                  round(row['harga'] * weight['harga'] +
                        row['kualitas_kamera'] * weight['kualitas_kamera'] +
                        row['kapasitas_baterai'] * weight['kapasitas_baterai'] +
                        row['kinerja'] * weight['kinerja'] +
                        row['ukuran_layar'] * weight['ukuran_layar'], 5)
                  for row in self.normalized_data
                  }
        sorted_result = dict(sorted(result.items(), key=lambda x: x[1]))
        return sorted_result

class SimpleAdditiveWeighting(BaseMethod):

    @property
    def calculate(self):
        weight = self.weight
        result = {row['id_ponsel']:
                  round(row['harga'] * weight['harga'] +
                        row['kualitas_kamera'] * weight['kualitas_kamera'] +
                        row['kapasitas_baterai'] * weight['kapasitas_baterai'] +
                        row['kinerja'] * weight['kinerja'] +
                        row['ukuran_layar'] * weight['ukuran_layar'], 5)
                  for row in self.normalized_data
                  }
        sorted_result = dict(sorted(result.items(), key=lambda x: x[1]))
        return sorted_result

def run_saw():
    saw = SimpleAdditiveWeighting()
    print('Simple Additive Weighting result:')
    print(saw.calculate)

def run_wp():
    wp = WeightedProduct()
    print('Weighted Product result:')
    print(wp.calculate)

if len(sys.argv) > 1:
    arg = sys.argv[1]

    if arg == 'create_table':
        create_table()
    elif arg == 'saw':
        run_saw()
    elif arg == 'wp':
        run_wp()
    else:
        print('command not found')
