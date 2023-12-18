from typing import List
from sqlalchemy import ForeignKey, String
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, relationship


class WelcomeModel:
    def __init__(self):
        self.message = "Hello World!"

class Base(DeclarativeBase):
    pass

class Product(Base):
    __tablename__ = "product"
    id: Mapped[int] = mapped_column(primary_key=True)
    sku: Mapped[str] = mapped_column(String(30), unique=True)
    brand: Mapped[str] = mapped_column(String(30))
    name: Mapped[str] = mapped_column(String(30))
    description: Mapped[str] = mapped_column(String(30))
    price: Mapped[float] = mapped_column()
    non_discountable: Mapped[bool] = mapped_column(default=False)

    cart_items: Mapped[List["CartItem"]] = relationship(
        back_populates="product", cascade="all, delete-orphan"
    )

    def __repr__(self) -> str:
        return f"Product(sku={self.sku!r}, brand={self.brand!r}, name={self.name!r})"
    

class Cart(Base):
    __tablename__ = "cart"
    id: Mapped[int] = mapped_column(primary_key=True)
    subtotal: Mapped[float] = mapped_column()
    shipping_fee: Mapped[float] = mapped_column()
    grand_total: Mapped[float] = mapped_column()
    coupon_code: Mapped[str] = mapped_column(String(30), nullable=True)

    cart_items: Mapped[List["CartItem"]] = relationship(
        back_populates="cart", cascade="all, delete-orphan"
    )

    def __repr__(self) -> str:
        return f"Cart(id={self.id!r})"


class CartItem(Base):
    __tablename__ = "cart_item"
    id: Mapped[int] = mapped_column(primary_key=True)
    cart_id: Mapped[int] = mapped_column(ForeignKey("cart.id"))
    cart: Mapped["Cart"] = relationship(back_populates="cart_items")

    product_id: Mapped[int] = mapped_column(ForeignKey("product.id"))
    product: Mapped["Product"] = relationship(back_populates="cart_items")

    qty: Mapped[int] = mapped_column()
    item_price: Mapped[float] = mapped_column()

class Promotion(Base):
    __tablename__ = "promotion"
    id: Mapped[int] = mapped_column(primary_key=True)
    coupon_code: Mapped[str] = mapped_column(String(30), unique=True)
    subtotal_discount: Mapped[float] = mapped_column(default=0)
    max_subtotal_discount: Mapped[float] = mapped_column(nullable=True)
    shipping_discount: Mapped[float] = mapped_column(default=0)
    max_shipping_discount: Mapped[float] = mapped_column(nullable=True)
    cashback: Mapped[float] = mapped_column(default=0)
    max_cashback: Mapped[float] = mapped_column(nullable=True)
