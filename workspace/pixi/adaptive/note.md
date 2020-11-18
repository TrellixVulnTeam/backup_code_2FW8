# PIXI屏幕自适应

## 启航
最近准备使用pixi.js做个课设,在初步体验了pixi.js后,感觉PIXI.js的定位并不是一个功能全面的H5游戏引擎,而是定位成多媒体交互框架————不仅仅用来做游戏。

大多数别的引擎开箱即用的功能PIXI都不存在😗,好在Laya提供的API足够支撑大多数功能的实现。今天就来实现一下大多数游戏引擎都提供的屏幕自适应。

## 目标
在大多数游戏中,我们都能看到游戏画面随着屏幕的放大缩小而放大缩小，且始终占据着屏幕的一部分空间。在浏览器中就表现为浏览器窗口放大缩小时游戏画面跟着放大缩小。

# First试一试
首先需要证实我们的想法是可以实现的,所以需要写一个基础的测试demo证明是可以实现自适应这个功能的。在此,我准备实现一个特殊的示例————一个高度使用占满浏览器,宽度随高度自适应的游戏canvas。

为了实现自适应这样的效果,首先要适应的是canvas的宽高,pixi Application实例中的renderer成员可以更改canvas的宽高,基础代码如下:

index.html
****
```
<!DOCTYPE html>
<html>

<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>PIXI Demo</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <style>
        * {
            padding: 0;
            margin: 0;
        }

        body {
            height: 100vh;
        }
    </style>
</head>

<body>
    <script src="./js/pixi.js"></script>
    <script type="text/javascript" src="./js/main.js"></script>
</body>

</html>
```

main.js
****
```
const app = new PIXI.Application({
    width: 480,
    height: 600
})

const loader = PIXI.loader
const Sprite = PIXI.Sprite
const Res = loader.resources

loader.add("./img/dxx.png").load(setup)

function setup() {
    let sprite = new PIXI.Sprite(Res['./img/dxx.png'].texture)
    console.log(app.stage)
    app.stage.addChild(sprite)
}


//创建调整画布大小函数的函数
function createResizeWindow(app) {
    //获得canvas的基本宽高
    const cWidth = app.view.width
    const cHeight = app.view.height

    //在需要改变canvas大小的时候调用
    return function() {
        //获取浏览器可视区域高度(使得canvas占满)
        const height = document.body.clientHeight
        //canvas宽度是跟随height比例变化的
        const width = cWidth * (height / cHeight)
        
        //使用计算出的新宽高调整画布大小
        app.renderer.resize(width, height)
    }
}

const resizeWindow = createResizeWindow(app)

document.body.appendChild(app.view)

//绑定load和resize事件,在这两个事件触发时自适应
window.addEventListener('load', resizeWindow)
window.addEventListener('resize', resizeWindow)

```

以上代码初步实现了高度铺满宽度自适应且显示了一个精灵。但注意到一个问题,在画布放大缩小时,其内部的精灵仍保持不变————这不是我们想要的结果。我们希望canvas内部的精灵也随着画布的大小而改变,始终占据画布的对应空间。为了实现这样的效果,就需要更改画布内的显示属性。app中的stage是整个app中的根显示容器,所有的显示对象都是添加到stage中的,即设置stage的Scale即可控制所有显示对象(精灵)的大小

main.js
****
```
function createResizeWindow(app) {
    ...
    return function() {
        ...
        app.stage.scale.set(height / cHeight, width / cWidth)
        app.renderer.resize(width, height)
    }
}
```

## 加强
基础效果已经实现了