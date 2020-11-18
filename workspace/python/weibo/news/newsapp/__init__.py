from flask import Flask
from newsapp.config import Config
 
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager
app = Flask(__name__)
app.config.from_object(Config)
app.debug = True
db = SQLAlchemy(app)
login_manager = LoginManager(app)


from newsapp import routes, models

@login_manager.user_loader
def load_user(userid):
    return models.User.query.filter_by(id = userid).first()
