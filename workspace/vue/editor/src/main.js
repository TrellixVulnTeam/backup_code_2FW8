import 'babel-polyfill'
import Vue from "vue"
import App from './components/App'
import Vuetify from "vuetify"
import 'vuetify/dist/vuetify.min.css'
import colors from 'vuetify/es5/util/colors'
import "./directives"
import store from "./store"

Vue.use(Vuetify, {
  theme: {
    primary: colors.red.darken1, // #E53935
    secondary: colors.red.lighten4, // #FFCDD2
    accent: colors.indigo.base // #3F51B5
  }
})

new Vue({
  el: "#app",
  ...App,
  async created() {
    await store.init()
  }
})
