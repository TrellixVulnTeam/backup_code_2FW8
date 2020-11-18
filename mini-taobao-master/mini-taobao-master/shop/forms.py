from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField, BooleanField, SelectField, TextAreaField, FloatField, IntegerField
from wtforms.validators import DataRequired, EqualTo, ValidationError, Length, Email, InputRequired
from shop.models import Customer, User
from flask_login import current_user


class RegistrationForm(FlaskForm):
    username = StringField('Username',
                           validators=[DataRequired(), Length(min=2, max=20)])
    email = StringField('Email',
                        validators=[DataRequired(), Email()])
    password = PasswordField(
        'Paddword', validators=[DataRequired(), Length(min=6, max=20)])
    confirm_password = PasswordField('Confrim Password',
                                     validators=[DataRequired(), EqualTo('password')])
    submit = SubmitField('Register')

    def validate_username(self, username):
        table = Customer

        user = table.query.filter_by(username=username.data).first()
        if user:
            raise ValidationError("This username has already been used. Change it!")

    def validate_email(self, email):
        table = Customer

        user = table.query.filter_by(email=email.data).first()
        if user:
            raise ValidationError("This email has already been used. Change it!")


class LoginForm(FlaskForm):
    email = StringField('Email',
                        validators=[DataRequired(), Email()])
    password = PasswordField('Password', validators=[DataRequired()])
    remember = BooleanField("Remember")
    submit = SubmitField('Login')


class CustomerDetailForm(FlaskForm):
    consignee = StringField("Consignee name", validators=[
                            InputRequired(), Length(max=20, min=2)])
    address = StringField("Shipping address", validators=[
                          InputRequired(), Length(min=10, max=40)])
    telephone = StringField(
        "Telephone", validators=[InputRequired(), Length(max=20, min=9)])
    submit = SubmitField("Add Address")


class UpdateCustomerDetailForm(FlaskForm):
    consignee = StringField("Consignee name", validators=[
                            InputRequired(), Length(max=20, min=2)])
    address = StringField("Shipping address", validators=[
                          InputRequired(), Length(min=10, max=40)])
    telephone = StringField(
        "Telephone", validators=[InputRequired(), Length(max=20, min=9)])
    submit = SubmitField("Change address")


class SecurityCheck(FlaskForm):
    password = PasswordField('Password', validators=[DataRequired()])

    submit = SubmitField('Verify identidy')


class UpdateInfo(FlaskForm):

    username = StringField('Username',
                           validators=[DataRequired(), Length(min=2, max=20)])
    email = StringField('Email',
                        validators=[DataRequired(), Email()])

    submit = SubmitField('Update username and email')

    def validate_username(self, username):
        table = Customer

        user = table.query.filter_by(username=username.data).first()
        if user and user.username != current_user.username:
            raise ValidationError("This username has already been used. Change it!")

    def validate_email(self, email):
        table = Customer

        user = table.query.filter_by(email=email.data).first()
        if user and user.username != current_user.username:
            raise ValidationError("This email has already been used. Change it!")


class UpdatePasswordForm(FlaskForm):
    password = PasswordField(
        'Password', validators=[DataRequired(), Length(min=6, max=20)])
    confirm_password = PasswordField('Confirm Password',
                                     validators=[DataRequired(), EqualTo('password')])
    submit = SubmitField('Update Password')
