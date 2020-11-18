class TableScene extends eui.Component implements eui.UIComponent {
  private abc: eui.Label
  constructor() {
    super()
    this.skinName = 'resource/eui_skins/game/TableSkin.exml'
    this.abc.text = "load complete"
    
  }
}