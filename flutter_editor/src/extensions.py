from flask_sqlalchemy import SQLAlchemy
from flask_jwt_extended import JWTManager

db = SQLAlchemy()
jwt = JWTManager()

@jwt.user_claims_loader
def add_claims_to_access_token(user):
    return {
        'id': user.id,
        'username': user.username,
        'email': user.email
    }


@jwt.user_identity_loader
def user_identity_lookup(user):
    return user.email
