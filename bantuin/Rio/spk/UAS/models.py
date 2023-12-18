from sqlalchemy import Float
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column

class Base(DeclarativeBase):
    pass

class JamTangan(Base):
    __tablename__ = 'jam_tangan'
    id_jam_tangan: Mapped[str] = mapped_column(primary_key=True)
    harga: Mapped[int] = mapped_column()
    rating: Mapped[float] = mapped_column(type_=Float)
    baterai: Mapped[int] = mapped_column()
    kedalaman_tahan_air: Mapped[int] = mapped_column()
    berat: Mapped[int] = mapped_column()  
    
    def __repr__(self) -> str:
        return f"JamTangan(id_jam_tangan={self.id_jam_tangan!r}, harga={self.harga!r})"
