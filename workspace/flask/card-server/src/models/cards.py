from ..extensions import db
from .json_helper import JsonHelperMixin

class Card(db.Model, JsonHelperMixin):
    id = db.Column(db.Integer, primary_key=True)
    #卡片名称
    name = db.Column(db.String(31), nullable=False)
    #卡池权重
    weight = db.Column(db.Integer, nullable=False)
    #技能
    skill = db.Column(db.String(255))
    #职业
    job = db.Column(db.String(255))
    #卡片等级
    rare = db.Column(db.String(3), default='A', nullable=False)
    #近战
    melee = db.Column(db.String(1), default='A', nullable=False)
    #力量
    strength = db.Column(db.String(1), default='A', nullable=False)
    #体力
    ps = db.Column(db.String(1), default='A', nullable=False)
    #调查
    research = db.Column(db.String(1), default='A', nullable=False)
    #远程
    remote = db.Column(db.String(1), default='A', nullable=False)
    #敏捷
    speed = db.Column(db.String(1), default='A', nullable=False)
    #幸运
    lucky = db.Column(db.String(1), default='A', nullable=False)
    #交涉
    talk = db.Column(db.String(1), default='A', nullable=False)
    path = db.Column(db.Text, default='A', nullable=True)

    def __repr__(self):
        return "{0}({1})".format(self.name, self.rare)