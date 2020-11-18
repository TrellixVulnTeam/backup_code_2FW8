/**
 * @param {PIXI.Application} app pixi的实例
 * @return null
 */
export default function horizontal(app) {
    const cWidth = app.view.width
    const cHeight = app.view.height
    const cssTmpl = (width, height, origin, rotate) => `
        width: ${width};
        height: ${height};
        transform-origin: ${origin};
        transform: rotate(${rotate});
    `

    //使得canvas始终处于横置
    function horizontal(screenWidth, screenHeight) {
        const currWidth = app.view.width
        const currHeight = app.view.height

        /**
         * 强制横屏
         * 若宽度小于高度,表示目前在竖屏状态,此时需要旋转canvas模拟横屏
         * 返回处理后的屏幕宽高
         */
        if (screenWidth < screenHeight) {
            app.view.style = cssTmpl(currHeight, currWidth, "center", "90deg")
            return [screenHeight , screenWidth]
        } else {
            app.view.style = cssTmpl(currWidth, currHeight, "0", "0")
            return [screenWidth, screenHeight]
        }
    }

    //调整canvas大小
    function resize(width, height) {
        const radio = Math.min((width / cWidth), (height / cHeight))
        app.renderer.resize(cWidth * radio, cHeight * radio)
        app.stage.scale.set(radio, radio)
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