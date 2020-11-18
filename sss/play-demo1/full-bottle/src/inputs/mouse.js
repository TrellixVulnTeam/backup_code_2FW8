import Events from "../events";

const Mouse = (function () {
  /**
   * mouseDrag 鼠标拖动
   * mouseRClick 鼠标右键点击
   * mouseLClick 鼠标左键点击
   * mouseMClick 鼠标中键点击
   * mouseMMove 鼠标中键移动
   */

  let p5 = null;

  let mouseClickMap;
  let mouseMoveEvent;

  let prevX = 0;
  let prevY = 0;

  const init = (p5Ins) => {
    p5 = p5Ins;

    mouseClickMap = new Map([
      [p5.LEFT, false],
      [p5.CENTER, false],
      [p5.RIGHT, false],
    ]);

    mouseMoveEvent = new Map([
      [p5.LEFT, "mouseLeftHolder"],
      [p5.CENTER, "mouseCenterHolder"],
      [p5.RIGHT, "mouseRightHolder"],
    ]);
  }

  const update = () => {
    for (let key of mouseClickMap.keys()) {
      if (mouseClickMap.get(key)) {
        Events.emit(mouseMoveEvent.get(key))
      }
    }

    prevX = p5.mouseX;
    prevY = p5.mouseY;
  }

  const mousePressed = () => {
    mouseClickMap.set(p5.mouseButton, true)
  }

  const mouseReleased = () => {
    mouseClickMap.set(p5.mouseButton, false)
  }

  return {
    init,
    update,
    mousePressed,
    mouseReleased,
    get mouseX() {
      return p5.mouseX;
    },
    get mouseY() {
      return p5.mouseY;
    },
    get movedX() {
      return prevX - p5.mouseX;
    },
    get movedY() {
      return prevY - p5.mouseY;
    },
  }

})();

export default Mouse;