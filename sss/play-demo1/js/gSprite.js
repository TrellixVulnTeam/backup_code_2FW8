class gSprite extends gObject {
  constructor(x, y, width, height, parent = null) {
    super(parent);
    this._sprite = createSprite(x, y, width, height);
  }

  get sprite() {
    return this._sprite;
  }

  draw() {
    super.draw();
    drawSprite(this.sprite);
  }
}