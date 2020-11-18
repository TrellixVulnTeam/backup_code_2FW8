from flask import Flask
from .config import configure_app
from .extensions import cli, db, migrate, admin, jwt
from flask_migrate import MigrateCommand
from flask_admin.contrib.sqla import ModelView
from .models import Card
from .apis import user, base, card

BLUEPRINTS = [
    [base, '/'],
    [user, '/user'],
    [card, '/card'],
]

def create_app():
    app = Flask(__name__, static_folder="files")
    configure_app(app)
    configure_extensions(app)
    configure_blueprint(app)
    return app

def configure_blueprint(app):
    for api, url_prefix in BLUEPRINTS:
        app.register_blueprint(api, url_prefix = url_prefix)

def configure_extensions(app):
    db.init_app(app)
    migrate.init_app(app, db)
    cli.init_app(app)
    admin.init_app(app)
    jwt.init_app(app)
