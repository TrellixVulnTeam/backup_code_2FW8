import Scene from "./scene";
import { ObjectTypes } from "../utils/types";
import Events from "../events";
import behaviorTypes from "../behaviors/behaviorTypes";

export default class Game {

  /**
   * 
   * @param {Scene} scene 
   */
  constructor(gameData) {
    const { defaultScene = "default", scenes, objects = {} } = gameData;
    this.defaultScene = defaultScene;
    this.scenes = scenes;
    this.objectDatas = objects;
  }

  start() {
    this._scene = this.loadScene(this.scenes[this.defaultScene]);
  }

  update() {
    this._scene.update();
  }

  draw(paint) {
    this._scene.draw(paint);
  }

  /**
   * 设置场景
   * @param {Scene} scene 
   */
  set Scene(sceneName) {
    if (!!this.scene) {
      this._scene.stop();
    }

    this._scene = this.loadScene(this.scenes[sceneName]);
    this._scene.start();
  }

  loadScene(sceneData) {
    const { childs = [] } = sceneData;
    const scene = new Scene(this);

    childs.forEach(child => {
      const { type, propertys = {} } = child;
      const childType = this.objectDatas[type];
      if (!childType) {
        return;
      }

      this.loadGObject(scene, childType, propertys);
    });

    return scene;
  }

  loadGObject(scene, objectData, customPropertys = {}) {
    const { type = "gObject", args = [], events = [], propertys = {}, behaviors = [], handlers = [] } = objectData;

    /**
     * @param {Sprite} cIns
     */
    const cIns = new ObjectTypes[type](...args)

    handlers.forEach(({ type, callback }) => {
      cIns[type] = callback;
    })

    const finalPropertys = Object.assign({}, propertys, customPropertys);
    for (let key in finalPropertys) {
      cIns.loadProperty(key, finalPropertys[key])
    }

    cIns.addEvents(events)
    scene.addChild(cIns)
    //将events添加到对应对象实例中,等待对象激活后注册事件

    behaviors.forEach(({ type, args }) => {
      const behaivorIns = new behaviorTypes[type]()
      behaivorIns.setOption(args)
      cIns.addBehavior(behaivorIns)
    })

    return cIns;
  }

  instance(objectName, propertys = {}) {
    if (!Reflect.has(this.objectDatas, objectName)) {
      return;
    }

    this.loadGObject(this._scene, this.objectDatas[objectName], propertys);
  }
}