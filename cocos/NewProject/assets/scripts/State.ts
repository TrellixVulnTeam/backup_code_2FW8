export default class State {
  _states: Object = {};
  _events: Object = {};

  constructor(initStates = {}) {
    this._states = { ...initStates };

    for (let key in initStates) {
      this._events[key] = []
    }

  }
  private isExist(key) {
    if (!Reflect.has(this._states, key)) {
      this._states[key] = 0;
      this._events[key] = [];
    }
  }

  get(key: string) {
    this.isExist(key);
    return this._states[key];
  }

  set(key: string, value: number) {
    this.isExist(key);
    this._states[key] = value;
    this.cast(key);
  }

  add(key: string, value: number) {
    this.isExist(key);
    this._states[key] += value;
    this.cast(key);
  }

  inc(key: string) {
    this.add(key, 1);
  }

  dec(key: string) {
    this.add(key, -1);
  }

  listen(key: string, obj, callback) {
    this.isExist(key);
    this._events[key].push({
      obj,
      callback
    })

    this.cast(key)
  }

  delisten(key: string, obj) {
    let index = this._events[key].findIndex(e => e.obj === obj)
    this._events[key].splice(index, 1)
  }

  //广播
  cast(key: string) {
    this.isExist(key);
    if (this._events[key] instanceof Array) {
      for (let { obj, callback } of this._events[key]) {
        callback.call(obj)
      }
    }
  }

  clean() {
    for (let key in this._states) {
      this._states[key] = 0;
      this.cast(key);
    }
  }
}