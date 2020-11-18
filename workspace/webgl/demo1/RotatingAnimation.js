window.addEventListener('load', main)


let vertexSource = `
  //attribute 存储限定符
  attribute vec4 a_Position;
  uniform mat4 u_ModelMatrix;
  void main() {
    gl_Position = u_ModelMatrix * a_Position;
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
  const ANGLE_SPEED = 45
  let n = runVertexBuffer(gl)
  gl.clearColor(0.5, 0.5, 0.5, 1.0)
  let currentAngle = 0
  let modelMatrix = new Matrix4()
  let u_ModelMatrix = gl.getUniformLocation(gl.program, 'u_ModelMatrix')
  function tick() {
    currentAngle = animate(currentAngle, ANGLE_SPEED)
    draw(gl, currentAngle, modelMatrix, u_ModelMatrix, n)
    //动画循环
    requestAnimationFrame(tick)
  }

  tick()
}

let lastTime = Date.now()
function animate(angle, angleSpeed) {
  let currTime = Date.now()
  let deltaTime = currTime - lastTime
  lastTime = currTime
  return angle + (angleSpeed * deltaTime / 1000)
}

function draw(gl, angle, modelMatrix, u_ModelMatrix, n) {
  modelMatrix.setRotate(angle, 0, 0, 1)
  gl.uniformMatrix4fv(u_ModelMatrix, false, modelMatrix.elements)

  gl.clear(gl.COLOR_BUFFER_BIT)
  gl.drawArrays(gl.TRIANGLE_STRIP, 0, n)
}

function runVertexBuffer(gl) {
  let vertexs = new Float32Array([
    0.0, 0.5, -0.5, -0.5, 0.5, -0.5
  ])

  let n = 3

  let vertexBuffer = gl.createBuffer()

  /**
   * 绑定缓冲区对象
   */
  gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuffer)

  /**
   * 将数据写入缓冲区对象
   */
  gl.bufferData(gl.ARRAY_BUFFER, vertexs, gl.STATIC_DRAW)

  /**
   * 将缓冲区对象分配给attribute变量
   */
  let a_Position = gl.getAttribLocation(gl.program, 'a_Position')
  gl.vertexAttribPointer(a_Position, 2, gl.FLOAT, false, 0, 0)

  /**
   * 使缓冲区能够被顶点着色器访问
   */
  gl.enableVertexAttribArray(a_Position)

  return n
}