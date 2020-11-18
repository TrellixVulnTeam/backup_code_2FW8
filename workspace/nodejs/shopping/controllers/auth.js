const passport = require('../config/passport')
const User = require('../models/user')
exports.postLogin = passport.authenticate('local', {
  successRedirect: '/',
  failureRedirect: '/auth/login',
  failureFlash: true
})

exports.postSignup = function (req, res, next) {
  let newUser = new User({
    username: req.body.username,
    password: req.body.password,
    phoneNumber: req.body.phoneNumber,
    email: req.body.email
  })

  newUser.save(function (err, small) {
    if (err) {
      return res.redirect('/auth/signup')
    }
    return res.redirect('/auth/login')
  })
}

exports.postLogout = function (req, res, next) {
  req.logout()
  res.redirect('/')
}