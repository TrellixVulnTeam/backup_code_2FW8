class gObject {
  /**
   * 
   * @param {Number} x 
   * @param {Number} y 
   * @param {Number} width 
   * @param {Number} height 
   */
  constructor(parent = null) {
    this._components = [];
    this._componentMap = new Map();
    
    this.parent = parent;
    this.keyEvents = new Map();
  }

  set parent(parent) {
    if (parent instanceof Scene) {
      parent.addObject(this);
      this._parent = parent;
    }
  }

  get parent() {
    return this._parent;
  }

  destory() {
    this._components.forEach((component) => component.destory());
    this.parent.removeObject(this);
  }

  addComponent(component) {
    this._components.push(component);
    component.setParent(this);
    component.start();
    this._componentMap.set(component.constructor, component);
  }

  getComponent(componentType) {
    this._componentMap.get(componentType);
  }

  start() {
  }

  update() {
    this._components.forEach((component) => component.update());
    this.keyEvents.forEach((handle, keyCode) => {
      if (keyDown(keyCode)) {
        handle();
      }
    })
  }

  /**
   * 每帧自动调用的渲染方法一般不需要手动调用,由父类Scene统一调用
   */
  draw() {
    this._components.forEach((component) => component.draw());
  }

  stop() {

  }

  addKeyListener(keyCode, handle) {
    this.keyEvents.set(keyCode, handle);
  }

  removeKeyListener(keyCode) {
    this.keyEvents.delete(keyCode);
  }

}