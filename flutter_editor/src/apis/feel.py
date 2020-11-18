from flask import Blueprint, jsonify, request
from ..extensions import db
from ..models import Feel, Project
from flask_jwt_extended import (
    JWTManager, jwt_required, create_access_token,
    get_jwt_identity, get_jwt_claims, jwt_optional
)

feel = Blueprint('feel', __name__)


def getFeelByUserAndProject(user_id, project_id):
    feel = Feel.query.filter_by(
        user_id=user_id,
        project_id=project_id
    ).first()
    if feel is None:
        feel = Feel(user_id, project_id)
        db.session.add(feel)
    return feel


@feel.route('/like/<int:project_id>', methods=['GET'])
@jwt_optional
def get_likes(project_id):
    current_user = get_jwt_claims()

    is_user_like = False

    project = Project.query.filter_by(id=project_id).first()
    likes = len(list(filter(lambda f: f.is_like == True, project.feels)))

    if current_user:
        if len(list(filter(lambda f: f.is_like == True and f.user_id == current_user['id'], project.feels))) > 0:
            is_user_like = True

    return jsonify({
        'likes': likes,
        'is_user_like': is_user_like,
    }), 200


@feel.route('/like/<int:project_id>', methods=['POST'])
@jwt_required
def like(project_id):
    current_user = get_jwt_claims()
    feel = getFeelByUserAndProject(current_user["id"], project_id)
    feel.is_like = not feel.is_like
    db.session.commit()
    return jsonify({
        'is_like': feel.is_like,
    }), 200


@feel.route('/favorite/<int:project_id>', methods=['GET'])
@jwt_optional
def get_favorites(project_id):
    current_user = get_jwt_claims()
    is_user_favorite = False
    
    project = Project.query.filter_by(id = project_id).first()
    favorites = len(list(filter(lambda f: f.is_favorite == True, project.feels)))
    
    if current_user:
        if len(list(filter(lambda f: f.is_favorite == True and f.user_id == current_user['id'], project.feels))) > 0:
            is_user_favorite = True
            
    return jsonify({
        'favorites': favorites,
        'is_user_favorite': is_user_favorite
    }), 200

@feel.route('/favorite/<int:project_id>', methods=['POST'])
@jwt_required
def favorite(project_id):
    current_user = get_jwt_claims()
    feel = getFeelByUserAndProject(current_user["id"], project_id)
    feel.is_favorite = not feel.is_favorite
    db.session.commit()
    return jsonify({
        'is_favorite': feel.is_favorite
    }), 200
