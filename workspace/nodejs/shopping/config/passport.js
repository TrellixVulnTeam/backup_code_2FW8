const passport = require('passport')
const LocalStrategy = require('passport-local').Strategy;
const User = require('../models/user')
passport.use(new LocalStrategy(
  function (username, password, done) {
    User.findOne({ username: username }, function (err, user) {
      if (err) { return done(err); }
      if (!user) {
        return done(null, false, { message: 'Incorrect username.' });
      }
      if (!user.validPassword(password)) {
        return done(null, false, { message: 'Incorrect password.' });
      }
      return done(null, user);
    });
  }
));

passport.serializeUser(function (user, done) {
  done(null, user.id);
});

passport.deserializeUser(function (id, done) {
  User.findById(id, function (err, user) {
    done(err, user);
  });
});

passport.auth = function (successUrl = false, failedUrl = '/auth/login') {
  return function (req, res, next) {
    if (req.isAuthenticated()) {
      next();
    } else {
      res.redirect(failedUrl)
    }
  }
}

module.exports = passport