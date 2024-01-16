from sqlalchemy import select
from sqlalchemy.orm import Session
from sqlalchemy.exc import NoResultFound

from .models import Base, Product, Promotion
from engine import base_engine as engine

session = Session(engine)


def create_table():
    Base.metadata.create_all(engine)


def get_price(product_ids):
    query = select(Product).where(Product.id.in_(product_ids))
    prices = {
        product.id: product.price
        for product in session.scalars(query)
    }
    return {
        product_id: prices.get(product_id)
        for product_id in product_ids
    }
    

def get_subtotal(cart):
    cart_items = cart['cart_items']
    product_ids = [item['product_id'] for item in cart_items]
    price_map = get_price(product_ids)

    items_with_price = []
    subtotal = 0
    for item in cart_items:
        product_id = item['product_id']
        price = price_map.get(product_id)
        if price is None:
            continue
        item_subtotal = price * item['qty']
        cart_item = {
            **item,
            'item_price': price
        }
        items_with_price.append(cart_item)
        subtotal += item_subtotal

    cart['cart_items'] = items_with_price
    cart['subtotal'] = subtotal
    return cart


def get_promotion(coupon_code):
    query = select(Promotion).where(Promotion.coupon_code == coupon_code)
    try:
        result =  session.scalars(query).one()
    except NoResultFound:
        return {}
    return {
        'coupon_code': result.coupon_code,
        'subtotal_discount': result.subtotal_discount,
        'max_subtotal_discount': result.max_subtotal_discount,
        'shipping_discount': result.shipping_discount,
        'max_shipping_discount': result.max_shipping_discount,
        'cashback': result.cashback,
        'max_cashback': result.max_cashback
    }


def apply_promo(subtotal: float, shipping_fee: float, promotion: dict):
    return {
                'coupon_code': promotion['coupon_code'],
                'subtotal_discount': min(subtotal * promotion['subtotal_discount']/100, promotion['max_subtotal_discount']) 
                    if promotion['max_subtotal_discount'] is not None else subtotal * promotion['subtotal_discount']/100,
                'shipping_discount': min(shipping_fee * promotion['shipping_discount']/100, promotion['max_shipping_discount']) 
                    if promotion['max_shipping_discount'] is not None else shipping_fee * promotion['shipping_discount']/100,
                'cashback': min(subtotal * promotion['cashback']/100, promotion['max_cashback']) 
                    if promotion['max_cashback'] is not None else subtotal * promotion['cashback']/100
            }