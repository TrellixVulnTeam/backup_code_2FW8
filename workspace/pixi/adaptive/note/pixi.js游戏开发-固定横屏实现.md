# pixi.js游戏开发-固定横屏实现

## 起步
最近接触到pixi.js这个不能称之为游戏引擎的库,按pixi.js官网的说法pixi.js只是一个渲染器。之前一些其它引擎开箱即用的能力到了pixi.js这里就不得不自己实现或者是寻找他人已实现的开源代码。固定横屏就是所需要实现的一个非常重要的功能。

## 需求
首先,我们要确定什么是横屏?手机的常规方向是竖屏,旋转90度就是横屏。此时手机竖屏状态的高是横屏的宽,宽则是横屏的高。而手机的竖屏高大于宽的。因此我们可以将横屏想法简化为总是使用手机宽高比较大的一边作为游戏内容的宽,另一边作为高。
## 实现

在开始之前,先编写一下基本的css,使得游戏canvas一直处于窗口中央位置

```
<style>
    body {
        overflow: hidden;
        display: flex;
        justify-content: center;
        align-items: center;
    }
</style>
```

在自己实现固定横屏之前,我参考了两篇相关的文章:

1. [在pixi.js实现设备自适应和强制竖屏 by dtysky](http://dtysky.moe/article/Skill-2017_12_02_a)
2. [H5游戏开发：横屏适配 by Tingglelaoo](https://aotu.io/notes/2017/10/18/landscape_mode_in_html5_game/index.html)


结合了一上两位dalao的经验和实践,我摸索出一套自己的固定横屏实现方案,这套定义了一个横屏自适应处理方案,这个方案被我封装成为一个生成绑定函数:
```
function bindHorizontalWindoow(app) {
    const cWidth = app.view.width
    const cHeight = app.view.height
    const cssTmpl = (width, height, origin, rotate) => `
        width: ${width};
        height: ${height};
        transform-origin: ${origin};
        transform: rotate(${rotate});
    function horizontal(screenWidth, screenHeight) {
        //...
    }

    function resize(width, height) {
        //...
    }

    function todo() {
        const screenWidth = document.body.clientWidth
        const screenHeight = document.body.clientHeight
        
        const [width, height] = horizontal(screenWidth, screenHeight)
        resize(width, height)
    }
    window.addEventListener('load', todo)
    window.addEventListener('resize', todo)

    return todo
}
```
这个函数只有一个参数,使用时传入一个pixi Application实例,该函数先获取Application实例canvas的原始宽高(用于后面的计算)。

todo函数用于整合调用实现的函数。

return之前我们监听了两个事件,load事件再游戏第一次加载时调整canvas,resize事件在窗口大小发生变化时被调用。

我们知道,手机屏幕有两种状态——横屏和竖屏。我们需要的效果事使得游戏画面一直处于横屏状态,也就是说我们需要调整竖屏状态下的canvas旋转到横屏的状态,而横屏状态下的canvas则不做任何改变。直接使用CSS3就可以完成这样的效果。

horizontal函数接受屏幕宽度和高度,根据这两个参数设置css的表现,具体来说,如果屏幕宽度小于屏幕高度,我们认为是处于竖屏模式,此时就旋转整个画布90度且将竖屏宽度作为canvas的高度,再将竖屏高度作为canvas的宽度设置canvas大小并返回。返回的值会作为参数传入resize函数,使pixi实例的stage适配Canvas大小和比例。

```
//在窗口大小变化时调用,使得canvas始终处于横置
function horizontal(screenWidth, screenHeight) {
    const currWidth = app.view.width
    const currHeight = app.view.height

    /**
    * 强制横屏
    * 若宽度小于高度,表示目前在竖屏状态,此时需要旋转canvas模拟横屏
    * 返回处理后的屏幕宽高
    */
    if (screenWidth < screenHeight) {
        //将transform-origin设置为center,使其绕中心点旋转90度即可在竖屏下得到横屏效果
        app.view.style = cssTmpl(currHeight, currWidth, "center", "90deg")
        return [screenHeight , screenWidth]
    } else {
        app.view.style = cssTmpl(currWidth, currHeight, "0", "0")
        return [screenWidth, screenHeight]
    }
}
    `
```

至于适配屏幕,我需要的是一种 **Cover模式** 的屏幕适配方式,对于这种模式简单的解释是: **游戏stage会保持宽高比进行缩放适配浏览器的可视窗口。游戏stage会缩放至填满舞台内容。** 核心代码如下:

```
//调整canvas大小
function resize(width, height) {
    //这种缩放模式的缩放比例,为可视窗口与canvas宽度或高度比之间较大者
    const radio = Math.min((width / cWidth), (height / cHeight))
    app.renderer.resize(cWidth * radio, cHeight * radio)
    app.stage.scale.set(radio, radio)
}
```


