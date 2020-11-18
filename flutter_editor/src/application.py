from flask import Flask, Blueprint
from .config import DefaultConfig
from .extensions import db, jwt
from .models import User, Project
from . import apis
from flask_cors import CORS
from flask_admin import Admin
from flask_admin.contrib.sqla import ModelView
from . import admins

BLUEPRINTS = [
    [apis.user, '/user'],
    [apis.project, '/project'],
    [apis.comment, '/comment'],
    [apis.feel, '/feel'],
]

def create_app():
    app = Flask(__name__)
    configure_app(app, None)
    configure_extensions(app)
    configure_blueprint(app)
    return app

def configure_app(app, config):
    app.config.from_object(DefaultConfig)

    if config is not None:
        app.config.from_object(config)

def configure_extensions(app):
    db.init_app(app)
    jwt.init_app(app)
    admin = Admin(app, name='full_buttle_manager', template_mode='bootstrap3')
    admin.add_view(admins.UserModel(db.session, endpoint='user-admin'))
    admin.add_view(admins.ProjectModel(db.session, endpoint='project-admin'))
    admin.add_view(admins.CommentModel(db.session, endpoint='comment-admin'))
    admin.add_view(admins.FeelModel(db.session, endpoint='feel-admin'))
    CORS(app, supports_credentials=True)

def configure_blueprint(app):
    for api, url_prefix in BLUEPRINTS:
        app.register_blueprint(api, url_prefix="/api" + url_prefix)

def authenticate(email, password):
    user = User.query.filter_by(email=email).first()
    if user and safe_str_cmp(user.password.encode('utf-8'), password.encode('utf-8')):
        return user

def identity(payload):
    user_id = payload['identity']
    return User.query.filter_by(id=user_id).first()