class MoveComponent extends Component {
  constructor(speed) {
    super();
    this.speed = speed;
  }

  update() {
    if (keyIsDown(UP_ARROW)) {
      this.parent.sprite.position.y -= this.speed
    } else if (keyIsDown(DOWN_ARROW)) {
      this.parent.sprite.position.y += this.speed
    } else if (keyIsDown(LEFT_ARROW)) {
      this.parent.sprite.position.x -= this.speed
    } else if (keyIsDown(RIGHT_ARROW)) {
      this.parent.sprite.position.x += this.speed
    }
  }

}