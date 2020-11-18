import json
from flask import Blueprint, jsonify, request
from ..extensions import db

from flask_jwt_extended import (
    JWTManager, jwt_required, create_access_token,
    get_jwt_identity
)

from src.models import User
base = Blueprint('base', __name__)

@base.route('/')
def index():
    return 'hello world!'

@base.route('/login', methods=['POST'])
def login():
    if not request.is_json:
        return jsonify({"msg": "Missing JSON in request"}), 400

    username = request.json.get('username', None)
    password = request.json.get('password', None)

    if not username:
        return jsonify({"msg": "Missing username parameter"}), 400
    if not password:
        return jsonify({"msg": "Missing password parameter"}), 400

    curr_user = User.query.filter_by(username=username).first()
    if curr_user is None:
        return jsonify({"msg": "Bad username or password"}), 401
    
    if not curr_user.check_password(password):
        return jsonify({"msg": "Bad password"}), 401
    # Identity can be any data that is json serializable
    
    access_token = create_access_token(identity=json.dumps(curr_user.to_json()))
    return jsonify(access_token=access_token), 200

@base.route('/register', methods=['POST'])
def register():
    if not request.is_json:
        return jsonify({"msg": "Missing JSON in request"}), 400

    username = request.json.get('username', None)
    password = request.json.get('password', None)

    if not username:
        return jsonify({"msg": "Missing username parameter"}), 400
    if not password:
        return jsonify({"msg": "Missing password parameter"}), 400

    exist_user = User.query.filter_by(username=username).first()

    if exist_user is not None:
        return jsonify({"msg": "User Exists"}), 400

    new_user = User(username, password)
    db.session.add(new_user)
    db.session.commit()
    return jsonify({"msg": "Register Success"}), 200

@base.route('/hello', methods=['GET'])
@jwt_required
def hello():
    claims = get_jwt_claims()
    print(claims)
    return 'hello'

