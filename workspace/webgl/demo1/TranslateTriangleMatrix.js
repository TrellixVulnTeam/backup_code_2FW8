window.addEventListener('load', main)


let vertexSource = `
  //attribute 存储限定符
  attribute vec4 a_Position;
  uniform mat4 u_TransformMatrix;
  void main() {
    gl_Position = u_TransformMatrix * a_Position;
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

  let n = runVertexBuffer(gl)

  /**
   * 平移矩阵
   */
  let transformMatrix = new Float32Array([
    2.0, 0.0, 0.0, 0.0,
    0.0, 2.0, 0.0, 0.0,
    0.0, 0.0, 1.0, 0.0,
    0.0, 0.0, 0.0, 1.0,
  ])

  let u_TransformMatrix = gl.getUniformLocation(gl.program, 'u_TransformMatrix')
  gl.uniformMatrix4fv(u_TransformMatrix, false, transformMatrix)

  gl.clearColor(0.5 , 0.5, 0.5, 1.0)
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