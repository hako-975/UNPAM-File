from sqlalchemy import Float
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column

class Base(DeclarativeBase):
    pass

class Monitor(Base):
    __tablename__ = 'monitor'
    id_monitor: Mapped[str] = mapped_column(primary_key=True)
    harga: Mapped[int] = mapped_column()
    ukuran_layar: Mapped[int] = mapped_column()
    resolusi: Mapped[int] = mapped_column()
    refresh_rate: Mapped[int] = mapped_column()
    garansi: Mapped[int] = mapped_column()  
    
    def __repr__(self) -> str:
        return f"Monitor(id_monitor={self.id_monitor!r}, harga={self.harga!r})"
