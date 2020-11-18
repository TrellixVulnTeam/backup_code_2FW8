class Transform {
  /**
   * 
   * @param {Sprite} parent 
   */
  constructor(parent) {
    this.parent = parent
  }
  
  get x() {
    return this.parent.position.x;
  }

  set x(value) {
    this.parent.position.x = value;
  }

  get y() {
    return this.parent.position.y;
  }

  set y(value) {
    this.parent.position.y = value;
  }

  getProperty (propertyName) {
    return this.parent[propertyName];
  }

  setProperty (propertyName, value) {
    return this.parent[propertyName] = value;
  }
}

const proxyProperty = [
  "scale",
  "rotation",
  "visible",
  "rotationSpeed",
  "maxSpeed",
  "mass",
  "immovable",
  "friction",
  "dept",
  "shapeColor",
  "width",
  "height"
]

export default function createTransform(sprite) {
  let transform = new Transform(sprite);

  return new Proxy(transform, {
    get: (target, key, receiver) => {
      
      if (proxyProperty.indexOf(key)) {
        return target.getProperty(key)
      }

      return target[key];
    },
    set: (target, key, value, receiver) => {
      if (proxyProperty.indexOf(key) > -1) {
        return target.setProperty(key, value)
      }

      return target[key] = value
    }
  });
}