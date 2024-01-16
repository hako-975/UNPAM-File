from sqlalchemy import Float
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column

class Base(DeclarativeBase):
    pass

class HelmMotor(Base):
    __tablename__ = 'helm_motor'
    id_helm_motor: Mapped[str] = mapped_column(primary_key=True)
    harga: Mapped[int] = mapped_column()
    rating: Mapped[int] = mapped_column()
    berat: Mapped[int] = mapped_column()
    tingkat_keamanan: Mapped[int] = mapped_column()
    ventilasi: Mapped[int] = mapped_column()  
    
    def __repr__(self) -> str:
        return f"HelmMotor(id_helm_motor={self.id_helm_motor!r}, harga={self.harga!r})"
