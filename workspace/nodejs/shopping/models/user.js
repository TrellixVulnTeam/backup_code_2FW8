const mongoose = require('mongoose')

let UserSchema = new mongoose.Schema({
  username: {type: String, unique: true},
  password: {type: String},
  phoneNumber: {type: String},
  email: {type: String},
  isAdmin: {type: Boolean, default: false},
  carts: [{type: mongoose.Schema.Types.ObjectId, ref: 'cart'}]
})

UserSchema.methods.validPassword = function(password){
  return this.password === password
};

let UserModel = mongoose.model('user', UserSchema)

module.exports = UserModel