
const input = {
  mousedown: false,
  mouseup: false,
  prevMouseposition: { x: 0, y: 0 },
  mouseposition: { x: 0, y: 0 }
}

function initInput() {
  window.addEventListener('mousedown', e => {
    input.mousedown = true
    input.mouseup = false
  })

  window.addEventListener('mouseup', e => {
    input.mousedown = false
    input.mouseup = true
  })

  window.addEventListener('mousemove', e => {
    input.prevMouseposition = { ...input.mouseposition }
    input.mouseposition = { x: e.clientX, y: e.clientY }
  })
}