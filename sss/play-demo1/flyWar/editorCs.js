class EditorRun {
  constructor(scene) {
    this._scene = scene;
  }
  
  update() {
    this._scene.update();
    this._scene.draw();
  }
}

class Scene {
  constructor(width, height) {
    this.childs = [];
    this._rect = createSprite(0, 0, width, height);
    this._rect.shapeColor = color(255);
    this.width = width;
    this.height = height;
  }

  set width(value) {
    this._rect.width = value;
  }

  set height(value) {
    this._rect.height = value;
  }

  add(child) {
    this.childs.push(child);
    child.start();
  }

  remove(child) {
    let index = this.childs.indexOf(child);
    this.childs.splice(index, 1);
    child.destory();
  }

  update() {
    drawSprite(this._rect);
    this.childs.map((child) => child.update());
  }

  draw() {
    this.childs.map((child) => child.draw());
  }
} 
