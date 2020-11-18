var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
const session = require('express-session')

const passport = require('./config/passport')
const flash = require('connect-flash')
const expressWs = require('express-ws');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var authRouter = require('./routes/auth');
var cartRouter = require('./routes/cart');
let mongoose = require('mongoose')
mongoose.connect('mongodb://localhost:27017/myapp', (err) => {
  if (err) {
    console.log("连接失败");
  } else {
    console.log("连接成功");
  }
});

var app = express();
expressWs(app)

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use(session({ secret: 'helloworld!', cookie: { maxAge: null } }));
app.use(passport.initialize())
app.use(passport.session({ secret: 'keyboard cat' }))
app.use(flash())

app.use(function (req, res, next) {
  res.locals.user = req.user;
  next();
});

app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use('/auth', authRouter);
app.use('/cart', cartRouter);
require('./ws')(app)


// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404));
});

// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});


app.listen(3000)
module.exports = app;
