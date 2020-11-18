import { Application, Sprite, loader } from "pixi.js"
/**
 * stage的scale => 缩放率
 * view的宽高 => canvas大小
 */
global.app = new Application({
    width: 480, 
    height: 800,
})

bindWindowResisze(global.app)

document.body.appendChild(app.view)

loader.add("image/player.png").add("image/bg.jpg").load(onLoaded)

function onLoaded() {
    const spr = new Sprite(loader.resources['image/bg.jpg'].texture)
    spr.position.set(0, 0)
    app.stage.addChild(spr)
}

function bindWindowResisze(app) {
    //默认大小
    const cWidth = app.view.width
    const cHeight = app.view.height
    const windowResize = function () {
        //document.body.clientHeight是有问题的,clientHeight没有占满浏览器窗口。在CSS处已设置body的height:99vh才达到这种效果(不满意)
        const height = document.body.clientHeight

        //当前高度比例
        const heightScale = height / cHeight
        const width = cWidth * heightScale 

        //每次设置的scale都将重置,暂时基于原始宽高进行设置
        app.stage.scale.set(width / cWidth, height / cHeight)
        app.renderer.resize(width, height)
    }

    window.addEventListener('resize', windowResize)
    window.addEventListener('load', windowResize)
    return windowResize
}

