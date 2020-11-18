window.addEventListener('load', main)


let vertexSource = `
  //attribute 存储限定符
  attribute vec4 a_Position;
  attribute float a_PointSize;
  void main() {
    gl_Position = a_Position;
    gl_PointSize = a_PointSize;
  }
`

let fragmentSource = `
  void main() {
    gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
  }
`

function main() {
  let canvas = document.getElementById("canvas");
  let gl = getWebGLContext(canvas);
  let isInitShaders = initShaders(gl, vertexSource, fragmentSource)

  //获取a_Position存储在着色器中的地址
  let a_Position = gl.getAttribLocation(gl.program, 'a_Position');

  let a_PointSize = gl.getAttribLocation(gl.program, 'a_PointSize');

  //向着色器传值
  gl.vertexAttrib3f(a_Position, 0.5, 0.5, 0.0)
  gl.vertexAttrib1f(a_PointSize, 50.0)
  
  //指定清空颜色
  gl.clearColor(1.0, 0.0, 0.0, 1.0);

  //清空
  gl.clear(gl.COLOR_BUFFER_BIT)

  gl.drawArrays(gl.POINTS, 0, 1)
}