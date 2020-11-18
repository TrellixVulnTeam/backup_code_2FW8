const notifyTemp = (message) => `
  <div class="notify">
    ${message}
  </div>
`

function createDom(str) {
  let node = document.createElement("div")
  node.innerHTML = str
  return node.children[0]
}


const notifyList = document.querySelector("#notifys")

function notify(message) {
  const n = createDom(notifyTemp(message))
  notifyList.appendChild(n)
  setTimeout(function () {
    n.addEventListener('animationend', function () {
      notifyList.removeChild(n);
    })
    n.style.animation = "move-out .5s ease";
  }, 3000)
}


// let notifyPrepareList = []
// let timer = null
// let turn = false
// function newNotify() {
//   notify(notifyPrepareList.shift())
//   if (notifyPrepareList.length > 0) {
//     timer = setTimeout(newNotify, 1000)
//   } else {
//     timer = null
//   }
// }

// function showNotify(message) {
//   notifyPrepareList.push(message)
//   if (!timer) {
//     newNotify()
//   }
// }