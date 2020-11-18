from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_cli import FlaskCLI

cli = FlaskCLI()
db = SQLAlchemy()
migrate = Migrate()
from .jwt_ext import jwt
from .admin_ext import admin