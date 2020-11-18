import Vue from 'vue'
import Vuex from 'vuex'
import { $fetch } from '../plugins/fetch'
import router from '../router';
import { inherits } from 'util';

Vue.use(Vuex)

const store = new Vuex.Store({
    //state是只读的,你不能直接修改它
    state() {
        return {
            user: null,
        }
    },
    getters: {
        user: state => state.user,
        userPicture: (state, getters) => {
            const user = getters.user
            if (user) {
                const photos = user.profile.photos
                if (photos.length !== 0) {
                    return photos[0].value
                }
            }
        }
    },
    mutations: {
        user: (state, user) => {
            state.user = user
        }
    },
    //严格模式，禁止使用异步调用mutations
    strict: true,
    actions: {
        async init({ dispatch }) {
            await dispatch('login')
        },
        async login({ commit }) {
            try {
                const user = await $fetch('user')
                commit('user', user)

                if (user) {
                    router.replace(router.currentRoute.params.wantedRoute ||
                        { name: 'home' })
                }
            } catch(e) {
                console.warn(e)
            }
            
        },
        async logout({ commit }) {
            commit('user', null)

            $fetch('logout')

            if (router.currentRoute.matched.some(r => r.meta.private)) {
                router.replace({ name: 'home' , params: {
                    wantedRoute: router.currentRoute.fullPath
                }})
            }
        },
    }
})

export default store