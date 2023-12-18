import json

from api.models import Cart, CartItem

from .settings import DEFAULT_PRICE
from sqlalchemy import select, delete
from sqlalchemy.exc import NoResultFound
from sqlalchemy.orm import Session
from engine import base_engine as engine

session = Session(engine)

def test_product_detail_api(client):
    id = 3
    response = client.get(f"/api/products/{id}")
    assert response.status_code == 200
    data = json.loads(response.data)
    assert id == data.get('id')
    assert DEFAULT_PRICE * id


def test_product_api(client):
    response = client.get("/api/products")
    assert response.status_code == 200


def test_get_cart(client):
    cart_id = 1
    create_test_cart(cart_id)
    response = client.get(f"/api/cart/{cart_id}")
    assert response.status_code == 200
    data = json.loads(response.data)

    assert data['id'] == cart_id
    
    assert isinstance(data['cart_items'], list)
    assert len(data['cart_items']) > 0
    
    assert isinstance(data['eligible_promo'], dict)
    assert isinstance(data['cart_items'], list)
    assert isinstance(data['subtotal'], (int, float))
    

def create_test_cart(cart_id):
    cart = Cart(id=cart_id, coupon_code='LIVE', shipping_fee=0, subtotal=36000, grand_total=26000)
    cart_item = CartItem(product_id=1, qty=1, item_price=35000)
    cart.cart_items.append(cart_item)

    session.add(cart)
    session.commit()