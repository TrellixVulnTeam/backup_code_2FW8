const Cart = require('./models/cart')

const handlers = {
  getAll: function (ws, req, data) {
    Cart.find({
      user: req.user._id
    }).populate('product').then(function (value) {
      ws.send(JSON.stringify({
        type: 'getAll',
        data: {
          items: value
        }
      }))
    })
  },

  deleteCart: function(ws, req, data) {
    console.log('ddd');
    
    let cId = data.cid
    
    Cart.deleteOne({_id: cId}, function(err) {
      
    })
  }
}

module.exports = function (app) {
  app.ws('/ws', function (ws, req) {
    ws.on('message', function (msg) {
      let {type, data = []} = JSON.parse(msg)
      if (Reflect.has(handlers, type)) {
        handlers[type](ws, req, data)
      }
    });
  });
}