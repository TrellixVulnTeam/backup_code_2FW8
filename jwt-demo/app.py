from flask import Flask
from flask_jwt import JWT, jwt_required, current_identity
from werkzeug.security import safe_str_cmp


class User(object):
    def __init__(self, id, username, password):
        self.id = id
        self.username = username
        self.password = password

    def __str__(self):
        return "User(id='%s')" % self.id

users = [
    User(1, 'user1', 'abcxyz'),
    User(2, 'user2', 'abcxyz'),
]

username_table = {u.username: u for u in users}
userid_table = {u.id: u for u in users}

def auth(username, password):
  user = username_table.get(username)
  if user and safe_str_cmp(user.password.encode('utf-8'), password.encode('utf-8')):
    return user

def identity(payload):
  user_id = payload['identity']
  return userid_table.get(user_id, None)

app = Flask(__name__)
app.debug = True
app.config['SECRET_KEY'] = 'abcdefg'

jwt = JWT(app, auth, identity)

@app.route('/p')
@jwt_required()
def p():
  return '%s' % current_identity

if __name__ == "__main__":
    app.run()