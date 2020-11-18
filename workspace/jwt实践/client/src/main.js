import babelPolyfill from 'babel-polyfill'
import Vue from 'vue'
import router from "./router"
import App from './App.vue'
import VueFetch from "./plugins/fetch"
import VueState from "./plugins/state"
import state from "./state"

Vue.use(VueFetch, {
  baseUrl: "http://localhost:3000/"
})

Vue.use(VueState, state)

new Vue({
  el: '#app',
  router,
  render: h => h(App)
})
