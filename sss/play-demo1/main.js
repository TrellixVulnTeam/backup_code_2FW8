

let game;
let firstScene;
function setup() {
  createCanvas(800, 300);
  firstScene = new Scene();
  game = new Game(firstScene);
  let sprite = new gSprite(100, 100, 100, 100, firstScene);
  let box = new gSprite(500, 100, 100, 100, firstScene);
  sprite.addComponent(new MoveComponent(12))
  sprite.addComponent(new CollisionCompnent("default", "default", COLLISION.NONE))
  box.addComponent(new CollisionCompnent("default", "default", COLLISION.COLLIDE, () => {
    console.log("hello world!");
  }));
}

function draw() {
  background(255, 255, 255);
  game.update();
}

function mousePressed() {
  // firstScene.addObject(new Box(mouseX, mouseY, random(-5, 5), random(-5, 5)));
}