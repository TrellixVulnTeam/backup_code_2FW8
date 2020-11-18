const fs = require('fs')
let ejs = require('ejs')
const h = fs.readFileSync('./templates/a.html', 'utf8')

let data = {
  list:[
      {name:'zhangsan'},
      {name:'lisi'},
      {name:'wangwu'},
  ],

}

let html = ejs.render(h, data)
console.log(html)