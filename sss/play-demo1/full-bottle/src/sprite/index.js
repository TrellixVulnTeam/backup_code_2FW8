import gObject from "../core/gObject";
import { Scene } from "../core";
import Animation from "./animation";
import createTransform from "./transform";

export default class Sprite extends gObject {

  /**
   * 
   * @param {Number} x 
   * @param {Number} y 
   * @param {Image} image 
   * @param {Scene} parent 
   */
  constructor(x, y, animationName, parent = null) {
    super(parent);
    this._sprite = gObject.paint.createSprite(x, y, 100, 100)
    this.animation = new Animation(this._sprite)
    this.transform = createTransform(this._sprite)
    this.animation.set(animationName)
    this.isCollide = true;
  }

  draw(paint) {
    super.draw()
    paint.drawSprite(this._sprite)
  }

  get position() {
    return this._sprite.position
  }

  get velocity() {
    return this._sprite.velocity
  }

  loadProperty(propertyName, value) {
    console.log(propertyName, value);
    
    if (Reflect.has(this.transform, propertyName)) {
      this.transform[propertyName] = value
    } else {
      this[propertyName] = value
    }
    console.log(this.transform.x, this.position.x);
    

  }
}