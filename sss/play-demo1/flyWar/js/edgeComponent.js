class EdgeComponent extends Component {
  start() {
    this.sprite = this.parent.sprite;
  }

  update() {
    const sWidth = this.sprite.width / 2;
    const sHeight = this.sprite.height / 2;
    this.sprite.position.x = clamp(this.sprite.position.x, sWidth, width - sWidth);
    this.sprite.position.y = clamp(this.sprite.position.y, sHeight, height - sHeight);
  }
}