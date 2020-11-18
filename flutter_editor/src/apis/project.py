from flask import Blueprint, jsonify, request
from ..models import Project
from ..extensions import db
from flask_jwt_extended import (
    JWTManager, jwt_required, create_access_token,
    get_jwt_identity, get_jwt_claims
)

project = Blueprint('project', __name__)

# 获取所有项目
@project.route('/all', methods=['GET'])
def get_all_project():
    projects = Project.query.filter_by(is_publish=True).all()
    print([project.is_publish for project in projects])
    return  jsonify([p.to_preview_json() for p in projects])

    
# 获取对应项目
@project.route('/get/<id>', methods=['GET'])
def get_project_by_id(id):
    print('run')
    project = Project.query.filter_by(id=id).first()
    return jsonify(project.to_json())

# 新建项目
@project.route('/create', methods=['POST'])
@jwt_required
def create_project():
    current_user = get_jwt_claims()
    json_data = request.json.get('json', None)
    name = request.json.get('name', None)
    desc = request.json.get('desc', None)
    if json_data is None or name is None:
        return jsonify({
            'code': 400,
            'msg': '创建项目失败!'
        }), 400
    project = Project(current_user['id'], name, desc, json_data)
    db.session.add(project)
    db.session.commit()
    return jsonify(project.to_preview_json()), 200

# 发布项目
@project.route('/publish/<int:project_id>', methods=['PUT'])
@jwt_required
def publish_project(project_id):
    is_publish = request.json.get('is_publish', True)
    current_user = get_jwt_claims()
    project = Project.query.filter_by(
        id=project_id,
        user_id=current_user['id']
    ).first()

    if project is None:
        return jsonify({'code': 400, 'msg': '发布项目失败!'})

    project.is_publish = is_publish
    db.session.commit()
    return jsonify({
        'code': 200,
        'msg': '项目发布成功!'
    })

# 项目更新
@project.route('/update/<int:project_id>', methods=['post'])
@jwt_required
def update_project(project_id):
    json_data = request.get_json()
    current_user = get_jwt_claims()

    project = Project.query.filter_by(
        id=project_id,
        user_id=current_user['id'],
    ).first()

    if project is None:
        return jsonify({
            'code': 400,
            'msg': '更新项目失败!'
        })

    for key in json_data:
        setattr(project, key, json_data[key])
    db.session.commit()
    return jsonify({
        'code': 200,
        'msg': '更新项目成功!'
    })


# 删除项目
# 项目更新
@project.route('/delete/<int:project_id>', methods=['DELETE'])
@jwt_required
def delete_project(project_id):
    current_user = get_jwt_claims()
    project = Project.query.filter_by(
        id=project_id,
        user_id=current_user['id'],
    ).first()

    if project is None:
        return jsonify({
            'code': 400,
            'msg': '删除项目失败!'
        })

    db.session.delete(project)
    db.session.commit()
    return jsonify({
        'code': 200,
        'msg': '删除项目成功!'
    })

@project.route('/user')
@jwt_required
def get_current_user_projects():
    current_user = get_jwt_claims()
    projects = Project.query.filter_by(
        user_id = current_user['id']
    ).order_by(db.desc(Project.create_time)).all()

    projectJsons = [p.to_preview_json() for p in projects]
    return jsonify(projectJsons)
