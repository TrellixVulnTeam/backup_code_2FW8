import Vue from 'vue';
import VueRouter from 'vue-router'

import Login from './components/Login.vue'
import GeoBlog from './components/GeoBlog.vue'
import NotFound from './components/NotFound.vue'

import store from "./store"

Vue.use(VueRouter)

const routes = [
    { path: "/", name: "home", component: GeoBlog, meta: { private: true }  },
    { path: "/login", name: "login", component: Login },
    { path: "*", component: NotFound },
]

const router = new VueRouter({
    routes,
    mode: 'history',
})

router.beforeEach((to, from, next) => {
    console.log('to', to.name)
    const user = store.getters.user

    if (to.matched.some(r => r.meta.private) && !user) {
        next({
            name: 'login',
            params: {
                wantedRoute: to.fullPath
            },
        })
        return
    } else if (to.matched.some(r => r.meta.guest && user)) {
        next({name:'home'})
        return
    }

    next()
})

export default router