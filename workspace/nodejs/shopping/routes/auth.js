
var express = require('express');
var router = express.Router();
const passport = require('../config/passport')
const authController =require('../controllers/auth')

router.get('/login', (_, res) => res.render('login'));
router.post('/login', authController.postLogin);
router.get('/signup',(_, res) => res.render('signup'));
router.post('/signup', authController.postSignup);
router.get('/logout', passport.auth(), authController.postLogout);

module.exports = router