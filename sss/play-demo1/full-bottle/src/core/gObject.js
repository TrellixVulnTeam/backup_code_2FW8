import Scene from "./scene";
import Options from "../utils/Options";
import Events from "../events";
import { Collider, ColliderType } from "./collider";

export default class gObject {

  /**
   * @param {Scene} parent 
   */
  constructor(parent = null) {

    this.parent = parent;
    this._behaviors = [];
    this._events = [];
    
    //是否响应碰撞
    this.collider = new Collider();
    this._handleUpdate = () => { }
    this._handleStart = () => { }
    this._handleDestory = () => { }
  }

  /**
   * 
   * @param {Array} events 
   */
  addEvents(events) {
    this._events.push(...events);
  }

  /**
   * @param {Scene} parent
   */
  set parent(parent) {
    if (parent instanceof Scene) {
      this._parent = parent
    } else {
      this._parent = null
    }
  }

  get parent() {
    return this._parent
  }

  start() {
    /**
     * 绑定事件
     */
    console.log(this._events);
    
    this._events = this._events.map(({type, callback}) => {
      const nCallback = callback.bind(this)
      
      Events.on(type, nCallback)
      return {
        type,
        callback: nCallback
      }
    })
    this._handleStart()
  }

  update() {
    this._behaviors.forEach(behavior => behavior.update())
    this._handleUpdate()
  }

  /**
   * 每帧自动调用的渲染方法一般不需要手动调用,由父类Scene统一调用
   * @param {sketch} paint
   */
  draw(paint) {
    this._behaviors.forEach(behavior => behavior.draw(paint))
  }

  destory() {
    this._handleDestory()
    this._behaviors.forEach(behavior => behavior.destory())
    this._events.forEach(({type, callback}) => Events.off(type, callback))

    if (!!this.parent) {
      this.parent.removeChild(this);
    }
  }

  static get paint() {
    return gObject._paint
  }

  static set paint(paint) {
    gObject._paint = paint
  }

  set handleStart(func) {
    this._handleStart = func.bind(this)
  }

  set handleUpdate(func) {
    this._handleUpdate = func.bind(this)
  }

  set handleDestory(func) {
    this._handleDestory = func.bind(this)
  }

  addBehavior(behavior) {
    behavior.parent = this
    this._behaviors.push(behavior)
    behavior.start()
  }

  get options() {
    return Options
  }

  loadProperty(propertyName, value) {
    this[propertyName] = value
  }

  loadCollider({isCollider = false, colliderType = ColliderType.MOVED}) {
    this.collider.isCollider = isCollider
    this.collider.colliderType = colliderType
  }
}