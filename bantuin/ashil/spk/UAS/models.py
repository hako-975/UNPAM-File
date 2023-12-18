from sqlalchemy import Float
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column

class Base(DeclarativeBase):
    pass

class SikatGigi(Base):
    __tablename__ = 'sikat_gigi'
    id_sikat_gigi: Mapped[str] = mapped_column(primary_key=True)
    harga: Mapped[int] = mapped_column()
    kekerasan_bulu_sikat: Mapped[int] = mapped_column()
    bahan_bulu_sikat: Mapped[int] = mapped_column()
    ukuran_kepala_sikat: Mapped[int] = mapped_column()
    ulasan: Mapped[int] = mapped_column()  
    
    def __repr__(self) -> str:
        return f"SikatGigi(id_sikat_gigi={self.id_sikat_gigi!r}, harga={self.harga!r})"
