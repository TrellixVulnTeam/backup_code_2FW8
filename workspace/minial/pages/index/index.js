//index.js
//获取应用实例
const app = getApp()

Page({
  data: {
    items: [],
    money: 0,
  },
  onLoad: function() {
    let self = this;
    wx.request({
      url: 'http://127.0.0.1:5000/goods',
      header: {
        'content-type': 'application/json' // 默认值
      },
      success(res) {
        self.setData({
          items: res.data.map(d => ({
            ...d,
            num: 0,
          }))
        })
      }
    })
  },
  inc(e) {
    let id = e.currentTarget.dataset.id
    this.cal(id, 1)
  },
  div(e) {
    let id = e.currentTarget.dataset.id
    this.cal(id, -1)
  },
  cal(id, num) {
    let obj = null;
    for (let i = 0; i < this.data.items.length; i++) {
      if (this.data.items[i].id === id) {
        obj = this.data.items[i];
        break;
      }
    }
    // console.log(id, obj, this.data.items)

    if (!obj || obj.num + num < 0) {
      return;
    }
    obj.num += num

    this.setData({
      items: this.data.items
    })
  },
  bindKeyInput: function(e) {
    this.setData({
      money: e.detail.value
    })
  },
  generatorAnswer: function() {
    let money = this.data.money;
    if (money <= 0) {
      return;
    }

    let choose = [];
    let choose_num = [];
    this.data.items.forEach(function(item) {
      if (item.num > 0) {
        choose.push(item.id);
        choose_num.push(item.num);
      }
    })

    let self = this
    wx.request({
      url: 'http://127.0.0.1:5000/calc',
      header: {
        'content-type': 'application/json' // 默认值
      },
      data: {
        'choose': choose,
        'choose_num': choose_num,
        'money': money
      },
      method: 'post',
      success(res) {
        let data = res.data;
        if (!data instanceof Array) {
          wx.showToast({
            title: '服务器返回值错误',
            icon: 'error',
            duration: 2000
          })
          return;
        }
        console.log(data)
        let dItems = self.data.items
        let plans = data.map(function(d) {
          let [money, objs] = d
          let plan = {
            money: money.toFixed(2),
            items: [],
          }

          objs.forEach(function(id) {
            let item = plan.items.find(function(v) {
              return v.id === id;
            })

            if (!item) {
              item = dItems.find(function(v) {
                return v.id === id
              })

              if (item) {
                item = {...item}
                item.num = 0
                plan.items.push(item)
              }
            }

            item['num'] += 1
          })

          return plan
        })
        console.log("跳转")
        wx.navigateTo({
          url: '../result',
          success: function (res) {
            console.log("load")
            // 通过eventChannel向被打开页面传送数据
            res.eventChannel.emit('acceptDataFromOpenerPage', { data: plans })
          }
        })

      }
    })
  }
})