from ..extensions import db
from .json_helper import JsonHelperMixin
from datetime import datetime

class Store(db.Model, JsonHelperMixin):
    #该物品存储的id
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    #User.id作为主键的外键
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))
    #抽中的卡牌
    card_id = db.Column(db.Integer, db.ForeignKey('card.id'))
    created_time = db.Column(db.DateTime())

    #card的引用
    card = db.relationship('Card')
    #user的引用
    user = db.relationship('User')

    def __init__(self, user_id, card_id):
        self.user_id = user_id
        self.card_id = card_id
        self.created_time = datetime.utcnow()