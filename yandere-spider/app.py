from flask import Flask

app = Flask(__name__)


@app.route('/full_image')
def hello_world():
    return 'Hello World!'


if __name__ == '__main__':
    app.run()
S