from flask import Blueprint, jsonify, request
from ..models import User, Card, Store
from ..extensions import db
from sqlalchemy.sql import func
from random import randint
from flask_jwt_extended import (
    jwt_required,
    get_jwt_claims
)

card = Blueprint('card', __name__)

@card.route('/get_cards', methods=['post'])
@jwt_required
def get_cards():
    curr_user = get_jwt_claims()
    count = request.json.get('count', 1)
    sum_of_weight = db.session.query(
        func.sum(Card.weight)
    ).first()[0]

    cards = Card.query.all()

    new_cards = [get_card(cards, sum_of_weight) for i in range(0, count)]

    stroe_cards_to_user(curr_user['id'], new_cards)

    return jsonify({
        'msg': 200,
        'data': [card.to_json() for card in new_cards],
    })

def get_card(cards, sum_of_weight):
    card_weight = randint(0, sum_of_weight)
    curr = 0
    #遍历并查找出对应card
    for card in cards:
        if card_weight > curr and card_weight < curr + card.weight :
            return card 
        curr += card.weight

    return None
 
def stroe_cards_to_user(user_id, cards):
    for card in cards:
        s = Store(user_id, card.id)
        db.session.add(s)
    db.session.commit()

@card.route('/get_user_store')
@jwt_required
def get_user_store():
    curr_user = get_jwt_claims()
    stores = Store.query.filter_by(user_id = curr_user['id']).all()
    cards = [store.card.to_json() for store in stores]

    return jsonify({
        'msg': 200,
        'data': cards
    })