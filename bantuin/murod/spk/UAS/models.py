from sqlalchemy import Float
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column

class Base(DeclarativeBase):
    pass

class Baju(Base):
    __tablename__ = 'baju'
    id_baju: Mapped[str] = mapped_column(primary_key=True)
    harga: Mapped[int] = mapped_column()
    kenyamanan: Mapped[float] = mapped_column(type_=Float)
    ulasan: Mapped[float] = mapped_column(type_=Float)
    kualitas_warna: Mapped[float] = mapped_column(type_=Float)
    desain: Mapped[int] = mapped_column()  
    
    def __repr__(self) -> str:
        return f"Baju(id_baju={self.id_baju!r}, harga={self.harga!r})"
