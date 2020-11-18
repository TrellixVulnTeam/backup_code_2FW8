import { callbackify } from "util";

/**
 * cd计时器
 */
export default class ColdDown {
    constructor() {
        this.flags = {}
        this.times = {}
    }
    
    /**
     * 
     * @param {String} key 要获取的flag的键值 
     */
    get(key) {
        if (this.flags.hasOwnProperty(key) &&
            this.flags[key]) {
            this.flags[key] = false
            this._cd(key)
            return true
        }

        return false
    }

    /**
     * 
     * @param {String} key 
     * @param {Number} time 
     * @param {Boolean} defv 
     * @param {Function} callback
     */
    register(key, time, defv = true) {
        this.flags[key] = defv
        this.times[key] = time
    }
    
    _cd(key) {
        setTimeout(() => this.flags[key] = true, this.times[key])
    }
}