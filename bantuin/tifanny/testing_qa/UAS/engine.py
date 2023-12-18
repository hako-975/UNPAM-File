import os
from sqlalchemy import create_engine
from api.models import Base

from sqlalchemy import MetaData

meta = MetaData()

USER = os.getenv("DB_USER")
PASSWORD = os.getenv("DB_PASSWORD")
HOST = os.getenv("DB_HOST")
PORT = os.getenv("DB_PORT")
NAME = os.getenv("DB_NAME")

try:
    base_engine = create_engine(f'postgresql+psycopg2://{USER}:{PASSWORD}@{HOST}:{PORT}/{NAME}')
except Exception as e:
    base_engine = create_engine("sqlite://", echo=True)
    Base.metadata.drop_all(base_engine)
    Base.metadata.create_all(base_engine)