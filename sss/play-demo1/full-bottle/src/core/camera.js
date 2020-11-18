import Events from "../events";

/**
 * Camera不属于任何场景,是公立的
 */
class Camera {
  constructor() {
    this.p5 = null
  }

  init(p5Ins, options) {
    this.p5 = p5Ins
    const { events = [] } = options
    options.events = events.map(({type, callback}) => {
      const nCallback = callback.bind(this)
      Events.on(type, nCallback)
      return {
        type,
        callback: nCallback
      }
    })
  }

  getCameraProperty(propertyName) {
    return this.p5.camera[propertyName]
  }

  setCameraProperty(propertyName, value) {
    return this.p5.camera[propertyName] = value
  }
}

let camera = new Camera();
export default new Proxy(camera, {
  get: function (target, key, receiver) {
    if (Reflect.has(target, key)) {
      return target[key];
    }

    return target.getCameraProperty(key);
  },
  set: function (target, key, value, receiver) {
    if (Reflect.has(target, key)) {
      target[key] = value;
      return true;
    }

    return target.setCameraProperty(key, value);
  }
});