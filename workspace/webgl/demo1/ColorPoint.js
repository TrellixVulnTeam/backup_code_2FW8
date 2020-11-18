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
  //精度限定词指定变量范围
  precision mediump float;
  uniform vec4 u_FragColor;
  void main() {
    gl_FragColor = u_FragColor;
  }
`

function main() {
  let canvas = document.getElementById("canvas");
  let gl = getWebGLContext(canvas);
  let isInitShaders = initShaders(gl, vertexSource, fragmentSource)
  console.log(isInitShaders)
  //获取a_Position存储在着色器中的地址
  let a_Position = gl.getAttribLocation(gl.program, 'a_Position');
  let u_FragColor = gl.getUniformLocation(gl.program, 'u_FragColor');
  canvas.onmousedown = function(e) {
    click(e, gl, canvas, a_Position, u_FragColor)
  }
}

const g_points = []

function randomColor() {
  return [Math.random(), Math.random(), Math.random(), 1.0]
}
function click(e, gl, canvas, a_Position, u_FragColor) {
  let x = e.clientX
  let y = e.clientY
  let rect = e.target.getBoundingClientRect()
  x = ((x - rect.left) - canvas.width / 2) / (canvas.width / 2);
  y = (canvas.height / 2 - (y - rect.top)) / (canvas.height / 2)
  g_points.push([x, y, randomColor()])

  gl.clear(gl.COLOR_BUFFER_BIT)
  
  g_points.forEach(([x, y, color]) => {
    console.log(color);
    
    gl.vertexAttrib2f(a_Position, x, y)
    gl.uniform4f(u_FragColor, ...color)
    gl.drawArrays(gl.POINTS, 0, 1)
  })
  
}