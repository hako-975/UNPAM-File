from sqlalchemy import Float
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column

class Base(DeclarativeBase):
    pass

class KerusakanKomputer(Base):
    __tablename__ = 'komputer'
    id_komputer: Mapped[str] = mapped_column(primary_key=True)
    harga: Mapped[int] = mapped_column()
    kerusakan_komputer: Mapped[int] = mapped_column()
    kerusakan_baterai: Mapped[int] = mapped_column()
    kinerja: Mapped[int] = mapped_column()
    ukuran_layar: Mapped[float] = mapped_column(type_=Float)  
    
    def __repr__(self) -> str:
        return f"KerusakanKomputer(id_komputer={self.id_komputer!r}, harga={self.harga!r})"
