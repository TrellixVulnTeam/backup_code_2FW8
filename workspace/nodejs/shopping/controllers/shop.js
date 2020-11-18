const Product = require('../models/product')
const Cart = require('../models/cart')

exports.addNewProduct = function(req, res, next) {
  let p = new Product({
    name: req.body.name,
    price: req.body.price,
    type: req.body.type,
    img: req.file.filename
  })

  p.save(function() {
    res.redirect('/new-product')
  })
}

exports.getAll = function(req, res, next) {
  // return res.render('shopping', {
  //   products: [1, 2, 3],
  //   title :'sss'
  // })
  return Product.find({}).exec(function(err, data) {
    res.render('shopping', {
        products: data || [],
    })
  })
}

exports.get = function(req, res, next) {
  const _id = req.query.id
  console.log(_id);
  
  Product.findById(_id , function(err, d) {
    console.log(d);
    
    return res.render('detail', {
      id: d._id,
      name: d.name,
      price: d.price,
      type: d.type,
      img: d.img
    })
  })
}

exports.removeProduct = function(req, res, next) {
  let id = req.query.id
  
  
  Product.deleteOne({
    _id: id,
  }, function(err) {
    Cart.deleteMany({
      product: id,
    },  function(err) {
      res.redirect('/shopping')
    })
  })
}