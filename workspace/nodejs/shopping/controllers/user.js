let User = require("../models/user")
exports.InsertNewUser = function (username, password, phoneNumber, email) {
  return new Promise((resolve, reject) => {
    let newUser = new User({
      username,
      password,
      phoneNumber,
      email
    })
    newUser.save(function (err, small) {
      if (err) {
        reject(err)
      }
      resolve();
    })
  })

}
