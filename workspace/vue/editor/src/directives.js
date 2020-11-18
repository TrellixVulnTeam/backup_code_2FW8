import Vue from 'vue'

function throttle(fn, delta) {
    let prev = Date.now()
    return function () {
        let now = Date.now()

        if (now - prev > delta) {
            fn.apply(this, arguments)
            prev = Date.now()
        }
    }
}
let master;
let members = [];
Vue.directive('follow', {
    inserted(el, binding) {
        if (binding.modifiers.master) {
            master = el
            //函数节流(throrrle),最多33毫秒执行一次,即一秒至多30帧
            master.addEventListener('scroll', throttle( function(e) {
                //重点!!!!!!
                let pres = e.target.scrollTop / (e.target.scrollHeight - e.target.offsetHeight)
                for (let member of members) {
                    member.scrollTop = member.scrollHeight * pres;
                }
            }, 33))
        } else {
            members.push(el)
        }
    }
})