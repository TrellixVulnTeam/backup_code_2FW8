from flask import Blueprint, jsonify, request
from ..extensions import db
from ..models import Comment
from flask_jwt_extended import (
    JWTManager, jwt_required, create_access_token,
    get_jwt_identity, get_jwt_claims
)

comment = Blueprint('comment', __name__)

# 添加讨论
@comment.route('/add/<int:project_id>', methods=['post'])
@jwt_required
def add_comment(project_id):
    current_user = get_jwt_claims()
    print(request.json)
    message = request.json.get('message', None)
    comment = Comment(message, current_user['id'], project_id)
    db.session.add(comment)
    db.session.commit()
    return jsonify(comment.to_preview_json()), 200

# 获取所有讨论
@comment.route('/all/<project_id>')
def all_comment(project_id):
    comments = Comment.que  ry.filter_by(project_id = project_id).order_by(Comment.id.desc()).all()
    return jsonify([comment.to_preview_json() for comment in comments]), 200
