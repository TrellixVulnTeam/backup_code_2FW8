from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, BooleanField, SubmitField
from wtforms.validators import ValidationError, DataRequired, Email, EqualTo
from app.models import User

# 本文件(forms.py)包含项目中所使用的各种flask表单

# 关于flask表单的基本用法可以参见: http://www.bjhee.com/flask-ext7.html

class LoginForm(FlaskForm):
    '''
    : LoginForm: flask登录表单
    '''
    username = StringField('Username', validators=[DataRequired()])          # username: 用户名字段，validators参数列表指定该字段的验证方式，选用的DataRequired()验证方式保证用户输入不为空
    password = PasswordField('Password', validators=[DataRequired()])        # password: 密码字段
    remember_me = BooleanField('Remember Me')                                # remember_me: 勾选框字段
    submit = SubmitField('Login')                                             # submit: 提交按钮字段


class RegisterForm(FlaskForm):
    '''
    : RegisterForm: flask注册表单
    '''
    username = StringField('Username', validators=[DataRequired()])          # username: 注册用户名字段
    email = StringField('Email', validators=[DataRequired(), Email()])       # email: 邮箱字段，validators参数指定验证方式，DataRequired()验证保证用户输入非空，Email()验证保证用户输入为标准邮箱地址格式
    password = PasswordField('Password', validators=[DataRequired()])        # password: 注册密码字段
    password_repeat = PasswordField('Repeat Password', validators=[DataRequired(), EqualTo('password')])   # password_repeat: 重复密码字段，validators参数指定验证方式，DataRequired()验证保证用户输入非空，EqualTo('password')验证保证输入的密码与第一次输入的密码字段password相同
    submit = SubmitField('Sign up')                                             # submit: 提交按钮字段

class SubmitForm(FlaskForm):
    '''
    : SubmitForm: flask编写新微博表单
    '''
    body=StringField('New Message', validators=[DataRequired()])                    # body: 微博正文字段
    submit = SubmitField('Send')                                             # submit: 提交按钮字段

class ManageForm(FlaskForm):
    '''
    : ManageForm: 管理用户个人信息的表单
    '''
    description = StringField('About Myself', validators=[DataRequired()])       # description: 该用户的自我介绍和描述，String类型
    sign = StringField('Sign', validators=[DataRequired()])                     # sign: 用户个性签名
    job = StringField('Job', validators=[DataRequired()])                       # job: 用户职业
    location = StringField('Location', validators=[DataRequired()])             # location: 用户的所在地址
    submit = SubmitField('Update')                                                # submit: 提交按钮字段

class SearchForm(FlaskForm):
    '''
    : SearchForm: 全局搜索表单
    '''
    target = StringField('Keyword', validators=[DataRequired()])                     # target: 搜索关键字输入字段
    submit = SubmitField('Search')                                                # submit: 提交按钮字段
    
class CommentForm(FlaskForm):
    '''
    : : 评论提交表单
    '''
    target = StringField('New Comment', validators=[DataRequired()])                     # target: 搜索关键字输入字段
    submit = SubmitField('Submit')                                                # submit: 提交按钮字段
    
    
