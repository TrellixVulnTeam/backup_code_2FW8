
const COLLISION = {
  //固体碰撞,类似墙壁
  COLLIDE: "collide",
  //触发器
  OVERLAP: "overlap",
  //碰撞产生位移
  DISPLACE: "displace",
  //无
  NONE: "none",
};

const Groups = (function () {
  //分组
  const _groups = new Map();
  window.groups = _groups;
  function setGroup(groupName) {
    group = new Group();
    _groups.set(groupName, group);
    return group;
  }

  return {
    set: function (obj, name) {
      console.log(obj);
      
      if (obj.GroupName !== null) {
        Groups.remove(obj);
      }

      let group;
      if (!_groups.has(name)) {
        group = setGroup(name);
      } else {
        group = _groups.get(name);
      }

      group.add(obj.sprite);
    },

    remove: function (obj) {
      const group = _groups.get(obj.GroupName);

      if (!!group) {
        group.remove(obj.sprite);
      }
    },

    get: function (groupName) {
      if (_groups.has(groupName)) {
        return _groups.get(groupName);
      }

      const group = setGroup(groupName);
      return group;
    }
  }
})();

class CollisionCompnent extends Component {
  /**
   * 
   * @param {String} groupName
   * @param {String} collisionGroupName
   * @param {Number} collisionType
   */
  constructor(groupName = "default", collisionGroupName = "default", collisionType = COLLISION.NONE, handler = () => { }) {
    super();
    this._groupName = groupName;
    this.collisionGroupName = collisionGroupName;
    this.collisionType = collisionType;
    this._handler = handler;
  }

  start() {
    this.groupName = this._groupName;
  }

  //根据自设定的操作进行更新
  update() {

    if (this.collisionType == COLLISION.NONE) {
      return;
    }

    const collisionGroup = Groups.get(this.collisionGroupName);
    collisionGroup.forEach(sprite => {
      sprite[this.collisionType](this.parent.sprite, this._handler);
    });

  }

  set groupName(groupName) {
    this._groupName = groupName;
    //将当前对象的组设置为指定名称组
    Groups.set(this.parent, groupName);
  }

  get groupName() {
    return this._groupName;
  }

}