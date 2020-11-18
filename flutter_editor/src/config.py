import os
file_path = os.path.abspath(os.getcwd())+"\database.db"

class DefaultConfig:
    SECRET_KEY = 'secret'
    SQLALCHEMY_DATABASE_URI = 'sqlite:///' + file_path
    SQLALCHEMY_TRACK_MODIFICATIONS = True
    DEBUG = True
    #JWT 安全密钥
    JWT_SECRET_KEY='jwt_secret_key'
    JWT_ACCESS_TOKEN_EXPIRES = False
    FLASK_ADMIN_SWATCH = 'cerulean'
