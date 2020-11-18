export default {
    install(Vue, options) {
        Object.defineProperty(Vue.prototype, '$state', {
            get: () => options,
        })
    }
}