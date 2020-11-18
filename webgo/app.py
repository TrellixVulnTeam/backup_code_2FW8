from flask import Flask, render_template
from load_image import get_image_arr
app = Flask(__name__)


@app.route('/')
def index():
    images = get_image_arr("images/swiper") * 3
    return render_template('index.html', images=images)


@app.route('/cat')
def cat():
    images = ['images/cat01.jpg'] * 12
    return render_template('gallerys.html', title="cat", images=images)


@app.route('/dog')
def dog():
    images = ['images/dog01.jpg'] * 12
    return render_template('gallerys.html', title="cat", images=images)


@app.route('/family')
def family():
    images = ['images/dog01.jpg'] * 12
    return render_template('gallerys.html', title="family", images=images)

if __name__ == '__main__':
    app.run()
