import './style.css'
import { printMe } from './print'
import { add, mult } from './calc'

function hello() {
    console.log("hello!")
}

let p = document.createElement("p")
p.appendChild(document.createTextNode("AAAAA"))
p.classList.add('hello')
document.documentElement.appendChild(p)

console.log(add(100, 200))
console.log(mult(100, 200))

printMe()
if (module.hot) {
    module.hot.accept('./print.js', function() {
        console.log("Accepting the updated printMe module!")
    })
}