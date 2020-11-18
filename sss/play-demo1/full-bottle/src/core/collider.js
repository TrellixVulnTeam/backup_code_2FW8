/**
 * 碰撞管理器
 * 每个场景一个实例
 * 对于isCollider的对象进行遍历计算
 */
export class ColliderManager {
  constructor(scene) {
    this._scene = scene
  }

  /**
   * 3种碰撞类型
   * 墙壁
   * 触发器
   * 位移块
   */

  /**
   * 
   * @param {Array} childs 
   */
  update(childs) {
    childs.filter((child) => !child.collider.isCollider)
      .forEach((child) => {
        // child.colliderObjects.map()
      })
  }
}

export const ColliderType = {
  //墙壁
  STATIC: "overlap",
  //触发器
  TRIGGER: "",
  //移动
  MOVED: 3
}

export class Collider {
  constructor(isCollider = false, colliderType = ColliderType.MOVED) {
    this.isCollider = isCollider
    this.colliderType = colliderType
    this.colliderObjects = new Map();
  }
}