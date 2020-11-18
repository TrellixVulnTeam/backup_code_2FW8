from flask import render_template, flash, redirect, url_for, session, jsonify
from werkzeug.security import generate_password_hash, check_password_hash
from newsapp import app, db
from newsapp.forms import LoginForm, SignupForm,  SearchForm, PostNewTweetForm
from newsapp.models import User, Tweet
from flask_login import login_user, login_required, current_user, logout_user

@app.route('/')
@app.route('/index', methods = ['GET', 'POST'])
def index():
    form = SearchForm()
    tweets = []
    if form.validate_on_submit():
        tweet_title = "find results by '{0}'".format(form.search.data)
        tweets = Tweet.query.filter(Tweet.content.like(r'%{0}%'.format(form.search.data))).order_by(Tweet.create_time.desc()).all()
    else:
        tweet_title = 'all tweet'
        tweets = Tweet.query.order_by(Tweet.create_time.desc()).all()
    return render_template('index.html', title='Home', tweets=tweets, form=form, tweet_title = tweet_title)

@app.route('/manage')
@login_required
def manager():
    tweets = Tweet.query.filter_by(user_id=current_user.id).order_by(Tweet.create_time.desc()).all()
    return render_template('manage.html', title='Manage', tweets=tweets)


@app.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm()
    user_in_db = User.query.filter(User.username == form.username.data).first()
    if form.validate_on_submit():
        flash('Login requested for user {}'.format(form.username.data))
        if not user_in_db:
            flash('No user found with username: {}'.format(form.username.data))
            return redirect(url_for('login'))
        if (check_password_hash(user_in_db.password_hash, form.password.data)):
            flash('Login success!')
            login_user(user_in_db)
            return redirect(url_for('index'))
    return render_template('Login.html', title='Sign In', form=form)


@app.route('/signup', methods=['GET', 'POST'])
def signup():
    form = SignupForm()
    if form.validate_on_submit():
        if form.password.data != form.password2.data:
            flash('Passwords do not match!')
            return redirect(url_for('signup'))
        elif User.query.filter_by(username = form.username.data).first() is not None:
            flash('Username exists!')
            return redirect(url_for('signup'))
        passw_hash = generate_password_hash(form.password.data)
        user = User(username=form.username.data, email=form.email.data, password_hash=passw_hash)
        db.session.add(user)
        db.session.commit()
        session["USERNAME"] = user.username
        return redirect(url_for('index'))
    return render_template('signup.html', title='Register a new user', form=form)

@app.route('/send-tweet', methods=['GET', 'POST'])
@login_required
def post_tweet():
    form = PostNewTweetForm()
    if form.validate_on_submit():
        tweet = Tweet(current_user.id, form.content.data)
        db.session.add(tweet)
        db.session.commit()
        return redirect(url_for('index'))
    else:
        return render_template('send.html', form=form)

@app.route('/delete-tweet/<int:id>', methods=['POST'])
@login_required
def delete_tweet(id):
    tweet = Tweet.query.filter_by(id = id).first()
    if tweet.user_id == current_user.id:
        db.session.delete(tweet)
        db.session.commit()
        return jsonify({'msg': 'success'}), 200
    else:
        return jsonify({'msg': 'fail'}), 400

@app.route('/logout')
def logout():
    logout_user()
    return redirect(url_for('index'))
