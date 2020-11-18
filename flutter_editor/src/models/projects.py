from datetime import datetime
from ..extensions import db

class Project(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    name = db.Column(db.String(120), nullable=False)
    json = db.Column(db.Text, nullable=False)
    desc = db.Column(db.String(256), nullable=False)
    create_time = db.Column(db.DateTime, nullable=False,
                            default=datetime.utcnow)
    is_publish = db.Column(db.BOOLEAN, default=False)
    comments = db.relationship('Comment', backref=db.backref('project', lazy=True))
    feels = db.relationship('Feel', backref=db.backref('project', lazy=True))


    def __init__(self, user_id, name, desc, json):
        self.user_id = user_id
        self.name = name
        self.desc = desc
        self.json = json

    def __repr__(self):
        return '%r' % self.name

    def to_preview_json(self):
        return {
            'id': self.id,
            'name': self.name,
            'create_time': self.create_time,
            'user_id': self.user_id,
            'is_publish': self.is_publish,
            "desc": self.desc,
        }

    def to_json(self):
        return {c.name: getattr(self, c.name) for c in self.__table__.columns}
