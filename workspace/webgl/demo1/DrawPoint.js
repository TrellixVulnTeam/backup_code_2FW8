window.addEventListener('load', main)


let vertexSource = `
  void main() {
    gl_Position = vec4(0.0, 0.5, 0.0, 1.0);
    gl_PointSize = 10.0;
  }
`

let fragmentSource = `
  void main() {
    gl_FragColor = vec4(0.0, 1.0, 0.0, 1.0);
  }
`

function main() {
  let canvas = document.getElementById("canvas");
  let gl = getWebGLContext(canvas);
  let isInitShaders = initShaders(gl, vertexSource, fragmentSource)
  console.log(isInitShaders);
  
  //指定清空颜色
  gl.clearColor(0.0, 0.0, 1.0, 1.0);

  //清空
  gl.clear(gl.COLOR_BUFFER_BIT)

  gl.drawArrays(gl.POINTS, 0, 1)
}