from ..extensions import db
from .json_helper import JsonHelperMixin
from werkzeug.security import generate_password_hash,check_password_hash
from .stores import Store

class User(db.Model, JsonHelperMixin):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    password = db.Column(db.String(120), nullable=False)

    def __init__(self, username, password):
        self.username = username
        self.password = generate_password_hash(password)

    def check_password(self, give_password):
        return check_password_hash(self.password, give_password)

    def __repr__(self):
        return "{0}".format(self.username)