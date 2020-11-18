window.addEventListener('load', main)


let vertexSource = `
  attribute vec4 a_Position;
  attribute float a_Color;
  // varying vec4 v_Color;
  void main() {
    gl_Position = a_Position;
    gl_PointSize = 10.0;
    // v_Color = a_Color;
  }
`

let fragmentSource = `
  // varying vec4 v_Color;
  void main() {
    // gl_FragColor = v_Color;
    gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);  
  }
`


function main() {
  let canvas = document.getElementById("canvas");
  let gl = getWebGLContext(canvas);
  let isInitShaders = initShaders(gl, vertexSource, fragmentSource)

  let vertexs = new Float32Array([
    0.0, 0.5, 1.0, 0.0, 0.0,
    -0.5, -0.5, 0.0, 1.0, 0.0,
    0.5, -0.5, 0.0, 0.0, 1.0
  ])

  let vertexBuffer = gl.createBuffer()
  gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuffer)
  gl.bufferData(gl.ARRAY_BUFFER, vertexs, gl.STATIC_DRAW)
  let FSIZE = vertexs.BYTES_PER_ELEMENT

  let a_Position = gl.getAttribLocation(gl.program, 'a_Position')
  // gl.vertexAttribPointer(a_Position, 2, gl.FLOAT, false, FSIZE * 5, 0)
  // gl.enableVertexAttribArray(a_Position)

  let a_Color = gl.getAttribLocation(gl.program, 'a_Color')
  console.log(a_Color);
  
  // gl.vertexAttribPointer(a_Color, 3, gl.FLOAT)


  gl.clearColor(0.5, 0.5, 0.5, 1.0)
  gl.clear(gl.COLOR_BUFFER_BIT)
  gl.drawArrays(gl.TRIANGLES, 0, 3)
}