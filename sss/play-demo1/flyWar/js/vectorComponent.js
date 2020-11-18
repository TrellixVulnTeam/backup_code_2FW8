class VectorComponent extends Component {
  constructor(speedX, speedY) {
    super();
    this.speedX = speedX;
    this.speedY = speedY;
  }
  start() {
    this.parent.sprite.velocity.x = this.speedX;
    this.parent.sprite.velocity.y = this.speedY;
  }
}