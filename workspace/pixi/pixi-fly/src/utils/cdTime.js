/**
 * cdtime属性的自动更新类
 * 冷却时间到时便返回true
 * 否则返回false
 */
export default function cdTime(obj, key, cd) {
    let flag = true
    Object.defineProperty(obj, key, {
        get() {
            if (flag == true) {
                flag = false
                setTimeout(() => obj[key] = true, cd)
                return true
            }

            return false
        },
        set(val) {
            flag = val 
        }
    })
}