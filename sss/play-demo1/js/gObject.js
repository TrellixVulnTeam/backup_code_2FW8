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
    if (parent instanceof Scene) {
      parent.addObject(this);
    }
  }

  addComponent(component) {
    this._components.push(component);
    component.setParent(this);
    component.start();
    console.log(component.parent);
    
    this._componentMap.set(component.constructor, component);
  }

  getComponent(componentType) {
    this._componentMap.get(componentType);
  }

  start() {
  }

  update() {
    this._components.forEach((component) => component.update());
  }

  /**
   * 每帧自动调用的渲染方法一般不需要手动调用,由父类Scene统一调用
   */
  draw() {
    this._components.forEach((component) => component.draw());
  }

  stop() {

  }
}