class gSprite extends gObject {
  constructor(x, y, parent = null) {
    super(parent);
    this._sprite = createSprite(x, y, 0, 0);
  }

  get sprite() {
    return this._sprite;
  }

  draw() {
    super.draw();
    drawSprite(this.sprite);
  }
}