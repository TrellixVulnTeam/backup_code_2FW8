import { EventEmitter } from "events";
import server from "./game/config/server";

/**
 * 
 * @param {Function} func 
 * @param {Object} receiver 
 */
function co(func, receiver) {
    return (...args) => {
        return new Promise((resolve, reject) => {
            func.apply(receiver, [...args, resolve])
        })
    }
}

export const Net = {
    init: co(pinus.init),
    notify: pinus.notify,
    on: pinus.on,
    request: co(pinus.request),
    disconnect: pinus.disconnect,
}


/**
 * 网络数据分发
 */
export const NetManager = {
    _isConnection: false,
    _emitter: new EventEmitter(),
    init() {
        Net.init({
            host: server.host,
            port: server.port
        }).then(() => {
            this._isConnection = true
        })
    },
    request(route, params) {
        if (!this._isConnection) return;
        Net.request(route, params, d => {
            this._emitter.emit(route, d)
        })
    },
    listener(route, callback) {
        this._emitter.on(route, callback)
    },
    on: Net.on,
    notify: pinus.notify
}