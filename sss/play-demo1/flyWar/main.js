let game;
let firstScene;
let bg;

function createPlay(scene) {
  play = new gSprite(32, 32, scene);
  a1 = loadAnimation("./imgs/player.png");
  play.sprite.addAnimation("a1", a1);
  play.sprite.changeAnimation("a1");
  play.addComponent(new MoveComponent(6));
  play.addComponent(new EdgeComponent());
  play.addKeyListener("z", throttle(() => {
    Initialize(createButtle, [firstScene, play.sprite.position.x, play.sprite.position.y]);
  }, 200));
}

function createButtle(scene, x, y) {
  let bullet = new gSprite(x, y, scene);
  let s = loadAnimation("./imgs/bullet.png");
  bullet.sprite.addAnimation("s", s);
  bullet.sprite.changeAnimation("s");
  bullet.addComponent(new VectorComponent(0, -8));
  bullet.addComponent(new OutSideDistoryComponent());
  bullet.addComponent(new CollisionCompnent("bullet", "enemy", COLLISION.OVERLAP, (other) => {
    bullet.destory();
    other.destory();
  }));

}

function createBg(scene) {
  let bg = new gSprite(width / 2, height / 2, scene);
  let s = loadAnimation("./imgs/bg.jpg");
  bg.sprite.addAnimation("s", s);
  bg.sprite.changeAnimation("s");
}

function createEnemyManager(scene) {
  new Timer(scene, 500, () => createEnemy(scene));
}

function createEnemy(scene) {
  let enemy = new gSprite(random(0, width), -20, scene);
  let s = loadAnimation("./imgs/enemy.png");
  enemy.sprite.addAnimation("s", s);
  enemy.addComponent(new VectorComponent(0, 4));
  enemy.addComponent(new CollisionCompnent("enemy", "bullet"));
  enemy.addComponent(new OutSideDistoryComponent(0, -100, width, height));
}

function setup() {
  createCanvas(480, 640);
  firstScene = new Scene();
  game = new Game(firstScene);
  createBg(firstScene);
  createPlay(firstScene);
  createEnemyManager(firstScene);
}

function draw() {
  background(255, 255, 255);
  game.update();
}