from sqlalchemy import Float
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column

class Base(DeclarativeBase):
    pass

class MinyakRambut(Base):
    __tablename__ = 'minyak_rambut'
    id_minyak_rambut: Mapped[str] = mapped_column(primary_key=True)
    harga: Mapped[int] = mapped_column()
    kualitas: Mapped[int] = mapped_column()
    aroma: Mapped[int] = mapped_column()
    kemasan: Mapped[int] = mapped_column()
    ulasan: Mapped[int] = mapped_column()  
    
    def __repr__(self) -> str:
        return f"MinyakRambut(id_minyak_rambut={self.id_minyak_rambut!r}, harga={self.harga!r})"
