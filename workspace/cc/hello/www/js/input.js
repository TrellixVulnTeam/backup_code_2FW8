
const input = {
  mousedown: false,
  mouseup: false,
  mouseposition: {}
}

function moveHandle(e) {
  let touch = e.touches[0]
  input.mouseposition = { x: touch.clientX, y: touch.clientY }
}

function initInput() {
  window.addEventListener('touchstart', e => {
    input.mousedown = true
    input.mouseup = false
    moveHandle(e)
  })

  window.addEventListener('touchend', e => {
    input.mousedown = false
    input.mouseup = true
  })

  window.addEventListener('touchmove', moveHandle)
}