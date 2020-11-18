window.addEventListener('load', main)


let vertexSource = `
  //attribute 存储限定符
  attribute vec4 a_Position;
  void main() {
    gl_Position = a_Position;
    gl_PointSize = 10.0;
  }
`

let fragmentSource = `
  void main() {
    gl_FragColor = vec4(1.0, 1.0, 0.0, 1.0);
  }
`

function main() {
  let canvas = document.getElementById("canvas");
  let gl = getWebGLContext(canvas);
  let isInitShaders = initShaders(gl, vertexSource, fragmentSource)

  canvas.onmousedown = function(e) {
    click(e, gl, canvas, a_Position)
  }

  //获取a_Position存储在着色器中的地址
  let a_Position = gl.getAttribLocation(gl.program, 'a_Position');

  //向着色器传值
  gl.vertexAttrib3f(a_Position, 0.5, 0.5, 0.0)
  
  //指定清空颜色
  gl.clearColor(1.0, 0.0, 0.0, 1.0);

  //清空
  gl.clear(gl.COLOR_BUFFER_BIT)

  gl.drawArrays(gl.POINTS, 0, 1)
}

const g_points = []

function click(e, gl, canvas, a_Position) {
  let x = e.clientX
  let y = e.clientY
  let rect = e.target.getBoundingClientRect()
  x = ((x - rect.left) - canvas.width / 2) / (canvas.width / 2);
  y = (canvas.height / 2 - (y - rect.top)) / (canvas.height / 2)
  g_points.push([x, y])

  // gl.clear(gl.COLOR_BUFFER_BIT)
  
  g_points.forEach(([x, y]) => {
    gl.vertexAttrib2f(a_Position, x, y)
    gl.drawArrays(gl.POINTS, 0, 1)
  })
  
}