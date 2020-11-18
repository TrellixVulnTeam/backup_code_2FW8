const mongoose = require('mongoose')
const upload = require('../config/upload')

let ProductSchema = new mongoose.Schema({
  name: {type: String},
  price: {type: Number},
  img: {type: String},
  type: {type: String},
})

let ProductModel =  mongoose.model('product', ProductSchema)

module.exports = ProductModel