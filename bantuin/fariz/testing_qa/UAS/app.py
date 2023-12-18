import click
from flask import Flask
from flask.cli import with_appcontext
from flasgger import Swagger
import pytest

from api.routes import home_api
from api.utils import create_table


@click.command(name='create')
@with_appcontext
def create():
    create_table()
    print('tables is created!')


def create_app():
    app = Flask(__name__)

    app.config['SWAGGER'] = {
        'title': 'Simple Cart API',
    }
    swagger = Swagger(app) # noqa: F841

     ## Initialize Config
    app.config.from_pyfile('config.py')
    app.json.sort_keys = False
    app.register_blueprint(home_api, url_prefix='/api')
    app.cli.add_command(create)

    return app


if __name__ == '__main__':
    from argparse import ArgumentParser

    parser = ArgumentParser()
    parser.add_argument('-p', '--port', default=5000, type=int, help='port to listen on')
    args = parser.parse_args()
    port = args.port

    app = create_app()

    app.run(host='0.0.0.0', port=port)
