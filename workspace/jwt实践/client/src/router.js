import Vue from 'vue'
import VueRouter from "vue-router"

import Home from "./components/Home.vue"
import News from "./components/News.vue"
import Login from "./components/Login.vue"
import state from './plugins/state';

Vue.use(VueRouter)

const routes = [
    { path: "/", name: "home", component: Home },
    { path: "/news", name: "news", component: News, meta: {private: true}},
    { path: "/login", name: "login", component: Login, meta: {guest: true}},
]

const router = new VueRouter({
    routes,
    mode: "history",
})

router.beforeEach((to, from, next) => {
    if (to.matched.find(r => r.meta.private) &&
        !localStorage.getItem('user')) {
        return next({
            name: "login",
        })
    } else if (to.matched.find(r => r.meta.guest) &&
        localStorage.getItem('user')) {
        return next({
            name: "home",
        })
    } else {
        return next()
    }
})


export default router