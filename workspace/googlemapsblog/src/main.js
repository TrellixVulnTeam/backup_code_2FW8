import "babel-polyfill"
import Vue from 'vue'
import VueFetch from "./plugins/fetch"
import store from "./store"
import router from "./router"
import App from "./components/App"
import * as filters from "./filters"

for (const key in filters) {
  Vue.filter(key, filters[key])
}

Vue.use(VueFetch, {
    baseUrl: "http://localhost:3000/"
})

async function main() {
    //自动登录
    await store.dispatch('init')
    new Vue({
        el: "#app",
        ...App,
        router,
        store
    })
}

main()