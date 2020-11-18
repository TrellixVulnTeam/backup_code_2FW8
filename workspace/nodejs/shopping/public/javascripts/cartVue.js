
const actions = {
  //获取购物车所有物品
  getAll: {
    type: 'getAll',
  },
  deleteCart: function (cid) {
    return {
      type: 'deleteCart',
      data: {
        cid
      }
    }
  }
}

function putAction(action) {
  return JSON.stringify(action)
}

let app = new Vue({
  el: '#app',
  data: {
    socket: null,
    items: [],
  },
  computed: {
    totalPrice: function () {
      return this.items.reduce((a, t) => a + (t.product.price * t.count), 0)
    },
    hasItems: function() {
      return this.items.length > 0
    }
  },
  methods: {
    deleteCart(cart_id) {
      this.socket.send(putAction(actions.deleteCart(cart_id)))
      let index = this.items.findIndex(p => p._id === cart_id)
      
      if (index > -1) {
        toast('Remove Product Success', '#2b9939')
        this.items.splice(index, 1)
      } else {
        toast('Remove Product Failed', '#d63200')
      }
    },
  },
  created: function () {
    this.socket = new WebSocket('ws://localhost:3000/ws');
    console.log("创建websocket");
    let socket = this.socket
    let self = this
    this.socket.addEventListener('open', (event) => {
      socket.send(putAction(actions.getAll));
    });

    this.socket.addEventListener('message', (event) => {
      let { type, data } = JSON.parse(event.data)
      console.log(type, type === 'getAll');

      if (type === 'getAll') {
        this.items = data.items
      }
    });
  }
})

