from sqlalchemy import Float
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column

class Base(DeclarativeBase):
    pass

class Printer(Base):
    __tablename__ = 'printer'
    id_printer: Mapped[str] = mapped_column(primary_key=True)
    kecepatan_cetak: Mapped[int] = mapped_column()
    kualitas_cetak: Mapped[float] = mapped_column(type_=Float)
    koneksi: Mapped[float] = mapped_column(type_=Float)
    harga: Mapped[int] = mapped_column()
    berat: Mapped[float] = mapped_column(type_=Float)  
    
    def __repr__(self) -> str:
        return f"Printer(id_printer={self.id_printer!r}, kecepatan_cetak={self.kecepatan_cetak!r})"
