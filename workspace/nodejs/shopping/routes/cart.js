var express = require('express');
var router = express.Router();
const passport = require('../config/passport')
const CartController = require('../controllers/cart')


router.get('/', passport.auth(), CartController.GetAll);

router.post('/add', passport.auth(), CartController.AddToCart);

module.exports = router