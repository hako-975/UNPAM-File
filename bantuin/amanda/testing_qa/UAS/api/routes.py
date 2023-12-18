from http import HTTPStatus
from flask import jsonify, request, Blueprint
from flasgger import swag_from
from sqlalchemy import select, delete
from sqlalchemy.exc import NoResultFound
from sqlalchemy.orm import Session

from .models import Product, Cart, CartItem
from .utils import apply_promo, get_promotion, get_subtotal
from engine import base_engine as engine

home_api = Blueprint('api', __name__)

session = Session(engine)

@home_api.route('/products', methods=["GET"])
@swag_from({
    'responses': {
        HTTPStatus.OK.value: {
            'description': 'product list'
        }
    }
})
def products():
    """
        Product list
        ---
        parameters:
          - in: query
            name: q
            type: string
            required: false
          - in: query
            name: sku
            type: string
            required: false
        """
    keyword = request.args.get('q')
    sku = request.args.get('sku')
    query = select(Product)

    if keyword:
       query = query.where(Product.name.ilike(f'%{keyword}%'))
    
    if sku:
        sku_list = sku.split(',')
        query = query.where(Product.sku.in_(sku_list))

    result = [
        {   
            'id': product.id,
            'sku': product.sku,
            'brand': product.brand, 
            'name': product.name,
            'description': product.description, 
            'price': product.price,
            'non_discountable': product.non_discountable
            } 
            for product in session.scalars(query)
    ]

    return jsonify(result), HTTPStatus.OK.value


@home_api.route('/products/<id>', methods=["GET"])
@swag_from({
    'responses': {
        HTTPStatus.OK.value: {
            'description': 'product detail'
        },
        HTTPStatus.NOT_FOUND.value: {
            'description': 'product not found'
        }
    }
})
def product_detail(id):
    """
        Product Detail
        ---
        parameters:
          - in: path
            name: id
            type: string
            required: true
        """

    query = select(Product).where(Product.id == id)
    try:
        result =  session.scalars(query).one()
    except NoResultFound:
        return 'product not found', HTTPStatus.NOT_FOUND.value

    return {
         'id': result.id,
            'sku': result.sku,
            'brand': result.brand, 
            'name': result.name,
            'description': result.description, 
            'price': result.price,
            'non_discountable': result.non_discountable
    }, HTTPStatus.OK.value


@home_api.route('/cart', methods=["GET", "POST"])
@swag_from({
    'responses': {
        HTTPStatus.OK.value: {
            'description': 'cart list'
        }
    }
})
def carts():
    """
        list of active cart
        ---
        post:
            parameters:
              - in: body
                name: cart
                type: object
                required:
                    - cart_items
                properties:
                    coupon_code:
                        type: string
                    shipping_fee:
                        type: number
                    cart_items:
                        type: array
                        items:
                            type: object
                            required:
                                - product_id
                                - qty
                            properties:
                                product_id: 
                                    type: integer
                                qty: 
                                    type: integer
        """
    
    if request.method == 'POST':
        req_data = request.get_json()

        validated_data = get_subtotal(req_data)
     
        data = Cart(
            coupon_code=validated_data.get('coupon_code'),
            shipping_fee=validated_data.get('shipping_fee', 0),
            subtotal=validated_data['subtotal'],
            grand_total=validated_data['subtotal']+validated_data.get('shipping_fee', 0),
            cart_items=[CartItem(product_id=item['product_id'], qty=item['qty'], item_price=item['item_price']) for item in validated_data.get('cart_items', [])]
        )
        session.add(data)
        session.commit()
        return 'data created', HTTPStatus.OK.value
    else:
        query = select(Cart)

        return [{'cart_id': cart.id, 'grand_total': cart.grand_total} for cart in session.scalars(query)], HTTPStatus.OK.value


@home_api.route('/cart/<id>', methods=["GET", "PUT", "DELETE"])
@swag_from({
    'responses': {
        HTTPStatus.OK.value: {
            'description': 'cart'
        }
    }
})
def cart(id):
    """
        cart detail
        ---
        get:
            parameters:
              - in: path
                name: id
                type: integer
                required: true
        delete:
            parameters:
              - in: path
                name: id
                type: integer
                required: true
        put:
            parameters:
              - in: path
                name: id
                type: integer
                required: true
              - in: body
                name: cart
                type: object
                required:
                    - cart_items
                properties:
                    coupon_code:
                        type: string
                    cart_items:
                        type: array
                        items:
                            type: object
                            required:
                                - product_id
                                - qty
                            properties:
                                product_id: 
                                    type: integer
                                qty: 
                                    type: integer
        """
    if request.method == 'GET':
        query = select(Cart).where(Cart.id == id)
        try:
            result =  session.scalars(query).one()
        except NoResultFound:
            return 'cart not found', HTTPStatus.NOT_FOUND.value
        
        coupon_code = result.coupon_code

        promotion = get_promotion(coupon_code)

        eligible_promo = {'message': 'no eligible promo'}
        subtotal = result.subtotal
        shipping_fee = result.shipping_fee
        if promotion:
            eligible_promo = apply_promo(subtotal, shipping_fee, promotion)

        return {
            'id': result.id,
            'coupon_code': coupon_code,
            'shipping_fee': shipping_fee,
            'cart_items': [{'product_id': item.product_id, 'qty': item.qty}for item in result.cart_items],
            'subtotal': subtotal,
            'grandtotal': result.grand_total,
            'eligible_promo': eligible_promo
            
        }, HTTPStatus.OK.value

    if request.method == 'PUT':
        'update cart data'
        return {}, HTTPStatus.OK.value
    
    cart_query = delete(Cart).where(Cart.id == id)
    cart_item_query = delete(CartItem).where(CartItem.cart_id == id)
    
    session.execute(cart_item_query)
    session.execute(cart_query)
    session.commit()
    return f'cart-{id} deleted', HTTPStatus.OK.value
