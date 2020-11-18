
import os
file_path = os.path.abspath(os.getcwd())+"\database.db"

class BaseConfig:
    SECRET_KEY = 'secret'
    SQLALCHEMY_DATABASE_URI = 'sqlite:///' + file_path
    SQLALCHEMY_TRACK_MODIFICATIONS = True
    DEBUG = True
    #JWT 安全密钥
    JWT_SECRET_KEY='jwt_secret_key'
    JWT_ACCESS_TOKEN_EXPIRES = False
    FLASK_ADMIN_SWATCH = 'cerulean'

class ProductionConfig:
    pass

class DevelopmentConfig:
    DEBUG = True

CONFIG_MAPPER = {
    'production': ProductionConfig,
    'development': DevelopmentConfig,
}

def configure_app(app):
    app.config.from_object(BaseConfig)
    env_mode = os.getenv('FLASK_ENV') or 'development'
    if CONFIG_MAPPER[env_mode] is not None:
        app.config.from_object(CONFIG_MAPPER[env_mode])
    
    
