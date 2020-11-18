const VSHADER = `
  attribute vec4 a_Position;
  uniform mat4 u_MvpMatrix;
  void main() {
    gl_Position = u_MvpMatrix * a_Position;
  }
`

var FSHADER = `
precision mediump float;
uniform vec4 u_FragColor;
void main() {
  gl_FragColor = u_FragColor;
}
`;


window.addEventListener('load', main)


function main() {
  let canvas = document.querySelector("#canvas")
  let gl = initCanvasWithWebgl(canvas)


  let n = initVertexs(gl)

  var u_MvpMatrix = gl.getUniformLocation(gl.program, 'u_MvpMatrix');
  if (!u_MvpMatrix) {
    console.log('Failed to get the storage location of u_MvpMatrix');
    return;
  }
  // Set the eye point and the viewing volume
  var mvpMatrix = new Matrix4();
  mvpMatrix.setPerspective(30, 1, 1, 100);
  mvpMatrix.lookAt(3, 3, 7, 0, 0, 0, 0, 1, 0);

  // Pass the model view projection matrix to u_MvpMatrix
  gl.uniformMatrix4fv(u_MvpMatrix, false, mvpMatrix.elements);
  gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT)
  // gl.drawArrays(type, startN, endN);
  gl.drawElements(gl.TRIANGLES, n, gl.UNSIGNED_BYTE, 0);
}

function cameraLookAt(mat) {
  var viewMatrix = new Matrix4();
  viewMatrix.setLookAt(0.20, 0.25, 0.25, 0, 0, 0, 0, 1, 0);
  return viewMatrix
}

function initVertexs(gl) {
  let vertexs = new Float32Array([
    1.0, 1.0, 1.0,
    -1.0, 1.0, 1.0,
    -1.0, -1.0, 1.0,
    1.0, -1.0, 1.0,
    1.0, 1.0, -1.0,
    -1.0, 1.0, -1.0,
    -1.0, -1.0, -1.0,
    1.0, -1.0, -1.0,
  ])

  let buffer = gl.createBuffer()
  let FSIZE = vertexs.BYTES_PER_ELEMENT
  gl.bindBuffer(gl.ARRAY_BUFFER, buffer)
  gl.bufferData(gl.ARRAY_BUFFER, vertexs, gl.STATIC_DRAW)

  let a_Position = gl.getAttribLocation(gl.program, 'a_Position')
  if (a_Position < 0) {
    console.log('Failed to get the storage location of a_Position');
    return -1;
  }
  gl.vertexAttribPointer(a_Position, 3, gl.FLOAT, false, FSIZE * 3, 0)
  gl.enableVertexAttribArray(a_Position)


  let indices = new Uint8Array([
    //前
    0, 1, 2, 0, 2, 3,
    //后
    4, 5, 6, 4, 6, 7,
    //上
    4, 5, 1, 4, 1, 0,
    //下
    7, 5, 2, 7, 2, 3,
    //左
    1, 5, 6, 1, 6, 2,
    //右
    0, 4, 7, 0, 7, 3,
  ])
  let indexBuffer = gl.createBuffer();

  // Write the indices to the buffer object
  gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, indexBuffer);
  gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, indices, gl.STATIC_DRAW);
  return indices.length
}

function initCanvasWithWebgl(canvas) {
  let gl = getWebGLContext(canvas);
  let isShaders = initShaders(gl, VSHADER, FSHADER)
  if (isShaders) {
    gl.clearColor(1.0, 0.0, 0.0, 1.0)
    gl.enable(gl.DEPTH_TEST)
    return gl
  }


  return null
}