import { create } from "domain";

const Events = (function () {
  const eventMaps = new Map();
  /**
   * 创建事件
   * @param {*} eventName 
   */
  const _create = function (eventName) {
    eventMaps.set(eventName, []);
  }

  /**
   * 注册指定事件的响应函数
   * @param {String} eventName 
   * @param {Function} callback 
   */
  const on = function (eventName, callback) {
    if (!eventMaps.has(eventName)) {
      _create(eventName);
    }

    const event = eventMaps.get(eventName);
    event.push(callback);
  }

  const off = function(eventName, callback) {
    if (!eventMaps.has(eventName)) {
      return
    }

    const events = eventMaps.get(eventName);

    let dIndex = events.indexOf(callback);

    if (dIndex > -1) {
      events.splice(dIndex, 1)
    }
  }

  /**
   * 事件触发器
   * @param {String} eventName 
   * @param {Function} callback 
   */
  const emit = function (eventName, ...args) {
    const listeners = eventMaps.get(eventName);
    if (listeners instanceof Array) {
      listeners.forEach(callback => callback(...args));
    }
  }

  return {
    eventMaps,
    on,
    off,
    emit,
  }
})();

window.events = Events;
export default Events;