import factory
from factory.alchemy import SQLAlchemyModelFactory
from sqlalchemy.orm import Session
from engine import base_engine as engine

from .settings import DEFAULT_PRICE


from api.models import Cart, CartItem, Product

session = Session(engine)

class ModelFactory(SQLAlchemyModelFactory):
    class Meta:
        abstract = True
        sqlalchemy_session = Session()


class FactoryProduct(ModelFactory):
    sku = factory.sequence(lambda x: f'ABC{x+1}' )
    brand = factory.Faker('name')
    name = factory.Faker('name')
    description = factory.Faker('sentence')
    price = factory.sequence(lambda x: (x + 1) * DEFAULT_PRICE )
    non_discountable = factory.Faker('boolean')

    class Meta:
        model = Product


def test_product():
    product = FactoryProduct(id=2)
    assert product.price is not None
    
def create_factory():
    # create data product
    products = []

    for idx in range(5):
        id = idx + 1
        product = FactoryProduct(id=id)
        data = Product(
            sku=product.sku,
            brand=product.brand,
            name=product.name,
            description=product.description,
            price=product.price,
            non_discountable=product.non_discountable
        )
        products.append(data)

    # add all products to the session
    session.add_all(products)
    session.commit()

    # create data cart id
    cart_id = 2;
        
    # create data cart
    cart = Cart(id=cart_id, subtotal=36000, shipping_fee=0, grand_total=26000, coupon_code="LIVE")
    session.add(cart)
    session.commit()

    # create data cart items
    for idx in range(3):
        product = products[idx] 
        cart_item = CartItem(
            cart=cart,
            product=product,
            qty=idx + 1,
            item_price=product.price
        )
        session.add(cart_item)
    session.commit()

