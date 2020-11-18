const mongoose = require('mongoose')

let CartSchema = new mongoose.Schema({
  user: {type: mongoose.Schema.Types.ObjectId},
  product: {type: mongoose.Schema.Types.ObjectId, ref: 'product'},
  count: {type: Number},
})

let CartModel = mongoose.model('cart', CartSchema)

module.exports = CartModel