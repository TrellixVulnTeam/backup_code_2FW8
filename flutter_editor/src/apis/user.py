from flask import Blueprint, jsonify, request
from ..models import User
from ..extensions import db
from ..helper import return_json_state
from flask_jwt_extended import (
    JWTManager, jwt_required, create_access_token,
    get_jwt_identity, get_jwt_claims
)

user = Blueprint('user', __name__)
# 账号部分由于并不是严格的CURD功能, 所以不严格遵守Restful规范编写。
@user.route('/signup', methods=['post'])
def signup():
    username = request.json['username']
    email = request.json['email']
    password = request.json['password']

    new_user = User(username, email, password)
    db.session.add(new_user)
    db.session.commit()
    return return_json_state(200)


@user.route('/login', methods=['post'])
def login():
    email = request.json.get('email', None)
    password = request.json.get('password', None)

    user = User.query.filter_by(email=email).first()
    if user and user.password == password:
        #创建访问令牌
        access_token = create_access_token(identity=user)
        return jsonify(access_token=access_token), 200
    return jsonify({"msg": "error!"}), 400

# 修改密码
@user.route('/repassword', methods=['post'])
@jwt_required
def repassword():
    current_user = get_jwt_claims()
    old_password = request.json.get('old_password', None)
    new_password = request.json.get('new_password', None)
    if old_password is None or new_password is None or len(new_password) < 8:
        return jsonify({"msg": "修改密码失败"}), 400

    user = User.query.filter_by(email=current_user['email']).first()
    if user is not None:
        user.password = new_password
        db.session.commit()
    return jsonify({"msg": "修改密码成功"}), 200

# 测试是否登录
@user.route('/haslogin')
@jwt_required
def haslogin():
    ret = {
        'current_identity': get_jwt_identity(),  # test
        'current_roles': get_jwt_claims()  # ['foo', 'bar']
    }
    return jsonify(ret), 200

@user.route('/info')
@jwt_required
def user_info():
    ret = get_jwt_claims()  # ['foo', 'bar']
    return jsonify(ret), 200
