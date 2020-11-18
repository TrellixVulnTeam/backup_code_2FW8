class StartScene extends eui.Component implements eui.UIComponent {
    private next: eui.Button
    private username: eui.EditableText
    constructor() {
        super()
        this.skinName = 'resource/eui_skins/scene/StartSceneSkin.exml'
        this.next.addEventListener(egret.TouchEvent.TOUCH_TAP, this.nextToGameScene, this)
    }

    nextToGameScene(event: egret.TouchEvent) {
        GameManager.Instance.username = this.username.text
        SceneManager.Instance.changeScene(new GameScene())
    }

}