from sqlalchemy import Float
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column

class Base(DeclarativeBase):
    pass

class Mahasiswa(Base):
    __tablename__ = 'mahasiswa'
    id_mahasiswa: Mapped[str] = mapped_column(primary_key=True)
    prestasi: Mapped[int] = mapped_column()
    ekstrakurikuler: Mapped[int] = mapped_column()
    rekomendasi_dosen: Mapped[int] = mapped_column()
    rencana_studi: Mapped[int] = mapped_column()
    tes_kualifikasi: Mapped[int] = mapped_column()  
    
    def __repr__(self) -> str:
        return f"Mahasiswa(id_mahasiswa={self.id_mahasiswa!r}, prestasi={self.prestasi!r})"
