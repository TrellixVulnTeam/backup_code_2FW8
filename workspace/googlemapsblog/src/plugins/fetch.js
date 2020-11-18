import router from '../router'
import store from '../store';
/**
 * 编写一个Vue插件的基本方法
 */
let baseUrl

export async function $fetch(url, options) {
    const finalOptions = Object.assign({}, {
        headers: {
            'Content-Type': 'application/json'
        },
        credentials: 'include',
    }, options)

    let res = await fetch(`${baseUrl}${url}`, finalOptions)

    //正确返回
    if (res.ok) {
        return await res.json()
    }
    //若为403则跳转到login页进行用户验证 
    else if (res.status === 403) {
        store.dispatch('logout')
    }
    //若为其它错误则直接抛出错误
    else {
        let msg = await res.text()
        throw new Error(msg)
    }
}

export default {
    install(Vue, options) {
        baseUrl = options.baseUrl

        Vue.prototype.$fetch = $fetch
    },
}

