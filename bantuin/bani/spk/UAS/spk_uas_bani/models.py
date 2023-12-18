from sqlalchemy import Float
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column

class Base(DeclarativeBase):
    pass

class Komputer(Base):
    __tablename__ = 'komputer'
    id_komputer: Mapped[str] = mapped_column(primary_key=True)
    harga: Mapped[int] = mapped_column()
    berat: Mapped[float] = mapped_column(type_=Float)
    rating: Mapped[float] = mapped_column(type_=Float)
    garansi: Mapped[int] = mapped_column()
    kecepatan_processor: Mapped[float] = mapped_column(type_=Float)  
    
    def __repr__(self) -> str:
        return f"Komputer(id_komputer={self.id_komputer!r}, harga={self.harga!r})"
