class OutSideDistoryComponent extends Component {
  constructor(minX = 0, minY = 0, maxX = -1, maxY = -1) {
    super();
    this._minX = minX;
    this._minY = minY;
    this._maxX = maxX === -1 ? width : maxX;
    this._maxY = maxY === -1 ? height : maxY;
  }

  update() {
    const {x, y} = this.parent.sprite.position;
    if ((x < this._minX || x > this._maxX) || 
      (y < this._minY || y > this._maxY)) {
      this.parent.destory();
    }
  }
}