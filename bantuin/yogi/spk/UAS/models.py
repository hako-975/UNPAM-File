from sqlalchemy import Float
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column

class Base(DeclarativeBase):
    pass

class Motor(Base):
    __tablename__ = 'motor'
    id_motor: Mapped[str] = mapped_column(primary_key=True)
    harga: Mapped[int] = mapped_column()
    kecepatan_maksimum: Mapped[int] = mapped_column()
    konsumsi_bahan_bakar: Mapped[int] = mapped_column()
    ukuran_mesin: Mapped[int] = mapped_column()
    ulasan: Mapped[int] = mapped_column()  
    
    def __repr__(self) -> str:
        return f"Motor(id_motor={self.id_motor!r}, harga={self.harga!r})"
