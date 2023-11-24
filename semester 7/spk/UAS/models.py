from sqlalchemy import String, Float
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column

class Base(DeclarativeBase):
    pass

class MobilePhone(Base):
    __tablename__ = 'ponsel'
    id_ponsel: Mapped[str] = mapped_column(primary_key=True)
    harga: Mapped[int] = mapped_column()
    kualitas_kamera: Mapped[int] = mapped_column()
    kapasitas_baterai: Mapped[int] = mapped_column()
    kinerja: Mapped[int] = mapped_column()
    ukuran_layar: Mapped[float] = mapped_column(type_=Float)  
    
    def __repr__(self) -> str:
        return f"MobilePhone(id_ponsel={self.id_ponsel!r}, harga={self.harga!r})"
