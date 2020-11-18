from src.application import create_app, db

app = create_app()
from src.models import User
db.app = app
db.init_app(app)
db.create_all()
