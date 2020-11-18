class GameScene extends eui.Component implements eui.UIComponent {
  constructor() {
    super()
    this.skinName = 'resource/eui_skins/scene/GameSceneSkin.exml'
    console.log(GameManager.Instance.username);
  }
}