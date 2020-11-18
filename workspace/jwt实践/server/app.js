const express = require("express")
var bodyParser = require('body-parser')
var jwt = require("jsonwebtoken")

const secret = "$^%$DFgvlfds;skjgfvldjkl"
const userVerify = (req, res, next) => {
    const token = req.get('Authorization');

    if (!token) {
        res.status(403)
    }

    try {
        const decode = jwt.verify(token, secret);
        next()
    } catch (e) {
        res.status(403);
    }
}
app = new express();

// parse application/x-www-form-urlencoded  
app.use(bodyParser.urlencoded({ extended: false }))
// parse application/json  
app.use(bodyParser.json())   

app.all('*', function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Content-Type,Content-Length, Authorization, Accept,X-Requested-With");
    res.header("Access-Control-Allow-Methods","PUT,POST,GET,DELETE,OPTIONS");
    res.header("X-Powered-By",' 3.2.1')
    if(req.method=="OPTIONS") res.send(200);/*让options请求快速返回*/
    else  next();
});

app.get('/', (req, res) => {
    res.send("hello express!");
})

app.get("/news", userVerify, (req, res) => {
    res.json([
        {"id": 1, "title": "Comlink 4.0：使 Web Workers 简单易用", "content": "Web Workers 提供了一种离开主线程而在后台运行 JavaScript 的方式，并且现在 每个浏览器都开始支持它。Google 提供的 Comlink 消除了所有在使用它们时的麻烦，使其变得简单易用。基本上你都会用到它。"},
        {"id": 2, "title": "WebStorm 中 React, Angular 和 Vue.js 的最佳体验", "content": "WebStorm 是一个让开发更轻松更有趣的 IDE，有着智能代码完成、数十种重构方式和支持流行框架等功能，所有这些都是开箱即用。尝试全新 WebStorm 2019.1 版本。"},
        {"id": 3, "title": "Babylon.js 4.0：（非常）强大的 WebGL 图形引擎", "content": "非常重要的一次发布，他们为此准备了 一个时长 2 分钟的视频预告片！随着 4.0 的发布，Babylon 开始完全实现模块化，因此分发给终端用户的代码，比以往任何版本都更加精简。想要试试？尝试这个可编辑的 在线演示。"},
        {"id": 4, "title": "Visual Studio Code 支持“远程开发”", "content": "VS Code 编辑器实现了一个令人兴奋的新功能，能够直接使用（运行在 WSL、Docker 容器、SSH 物理机或虚拟机中的）remote workspaces(远程工作区)。"}
    ])
});

app.post("/login", (req, res) => {
    let token = jwt.sign({
        exp: Math.floor(Date.now() / 1000) + 60 * 60 * 24,
        user: req.body
    }, secret);

    res.json({
        code: 200,
        token,
    })
})

app.get("/logout", (req, res) => {
    
})

app.listen(3000);