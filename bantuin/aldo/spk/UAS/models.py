from sqlalchemy import Float
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column

class Base(DeclarativeBase):
    pass

class Rumah(Base):
    __tablename__ = 'rumah'
    id_rumah: Mapped[str] = mapped_column(primary_key=True)
    harga: Mapped[int] = mapped_column()
    lokasi: Mapped[int] = mapped_column()
    luas_tanah: Mapped[int] = mapped_column()
    luas_bangunan: Mapped[int] = mapped_column()
    fasilitas: Mapped[int] = mapped_column()  
    
    def __repr__(self) -> str:
        return f"Rumah(id_rumah={self.id_rumah!r}, harga={self.harga!r})"
