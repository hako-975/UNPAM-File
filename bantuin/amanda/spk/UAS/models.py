from sqlalchemy import Float
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column

class Base(DeclarativeBase):
    pass

class Kosmetik(Base):
    __tablename__ = 'kosmetik'
    id_kosmetik: Mapped[str] = mapped_column(primary_key=True)
    daya_tahan: Mapped[int] = mapped_column()
    rating: Mapped[int] = mapped_column()
    jenis_kulit: Mapped[int] = mapped_column()
    harga: Mapped[int] = mapped_column()
    kandungan: Mapped[int] = mapped_column()  
    
    def __repr__(self) -> str:
        return f"Kosmetik(id_kosmetik={self.id_kosmetik!r}, daya_tahan={self.daya_tahan!r})"
