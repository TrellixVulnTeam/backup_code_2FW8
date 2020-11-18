class MoveComponent extends Component {
  constructor(speed) {
    super();
    this.speed = speed;
  }

  start() {
    
  }

  update() {
    if (keyCode == UP_ARROW) {
      this.parent.sprite.position.y -= this.speed
    } else if (keyCode == DOWN_ARROW) {
      this.parent.sprite.position.y += this.speed
    } else if (keyCode == LEFT_ARROW) {
      this.parent.sprite.position.x -= this.speed      
    } else if (keyCode == RIGHT_ARROW) {
      this.parent.sprite.position.x += this.speed
    }
  }
}