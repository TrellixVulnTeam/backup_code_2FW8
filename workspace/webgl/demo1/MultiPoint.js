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

  let n = runVertexBuffer(gl)

  gl.clearColor(0.5 , 0.5, 0.5, 1.0)
  gl.clear(gl.COLOR_BUFFER_BIT)
  gl.drawArrays(gl.POINTS, 0, n)

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