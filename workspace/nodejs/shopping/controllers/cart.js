const Cart = require('../models/cart')
const User = require('../models/user')
exports.GetAll = function (req, res, next) {
  Cart.find({
    user: req.user._id
  }).populate('product').then(function (value) {

    res.render('cart', {
      items: value
    })
  })
}

exports.AddToCart = function (req, res, next) {
  let product = req.body.product_id
  let user = req.user.id

  Cart.findOne({
    user,
    product,
  }, function (err, data) {
    let cart = data
    if (!data) {
      cart = new Cart({
        user,
        product,
        count: 0,
      })
    }
    cart.count++

    cart.save(function (err) {
      if (err) {
        return res.json({
          code: 404,
          msg: 'Add To Cart Failed',
          color: '#d63200',

        })
      }
      res.json({
        code: 200,
        msg: 'Add To Cart Success',
        color: '#2b9939',
      })
    })
  })
}