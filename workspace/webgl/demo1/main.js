window.addEventListener('load', main)

function main() {
  let canvas = document.getElementById("canvas");
  let gl = getWebGLContext(canvas);

  //指定清空颜色
  gl.clearColor(0.0, 0.0, 1.0, 1.0);

  //清空
  gl.clear(gl.COLOR_BUFFER_BIT)
}