import Events from "../events";

const Keyword = (function () {
  let p5 = null;
  let downKeys = [];
  const init = (p5Ins) => {
    p5 = p5Ins;
  }

  const keyPressed = () => {
    Events.emit("keyPressed", p5.keyCode)
    downKeys.unshift(p5.keyCode)
  }

  const keyReleased = () => {
    Events.emit("keyReleased", p5.keyCode)
    let dIndex = downKeys.indexOf(p5.keyCode)
    if (dIndex > -1) {
      downKeys.splice(dIndex, 1)
    }
  }

  const keyIsDown = (keycode) => {
    downKeys.map(key => Events.emit("keyIsDown", key))
    return downKeys.indexOf(keycode) > -1;
  }

  return {
    init,
    keyPressed,
    keyReleased,
    keyIsDown,
  }
})();

export default Keyword;