from sqlalchemy import create_engine
from settings import (
    DATABASE_NAME,
    HOST,
    PASSWORD,
    PORT, 
    USER
)

engine = create_engine(f"postgresql+psycopg2://{USER}:{PASSWORD}@{HOST}:{PORT}/{DATABASE_NAME}")