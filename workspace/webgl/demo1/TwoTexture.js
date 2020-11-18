
var VERTEX_SHADER = `
attribute vec4 a_Position;
attribute vec2 a_TexCoord;
varying vec2 v_TexCoord;
void main() {
  gl_Position = a_Position;
  v_TexCoord = a_TexCoord;
}
`;

var FRAGMENT_SHADER = `
precision mediump float;
uniform sampler2D u_Sampler;
uniform sampler2D u_Sampler2;
varying vec2 v_TexCoord;
void main() {
  vec4 color1 = texture2D(u_Sampler, v_TexCoord);
  vec4 color2 = texture2D(u_Sampler2, v_TexCoord);
  gl_FragColor = color1 * color2;
}
`;

window.addEventListener('load', main)

function main() {
  let canvas = document.getElementById('canvas');

  let gl = getWebGLContext(canvas);

  let isShaders = initShaders(gl, VERTEX_SHADER, FRAGMENT_SHADER)
  console.log(isShaders);

  let n = initVertexBuffers(gl)

  gl.clearColor(0.0, 0.0, 0.0, 1.0)
  initTexture(gl, "./img/circle.gif").then(v => {
    let u_Sampler = gl.getUniformLocation(gl.program, 'u_Sampler');
    gl.uniform1i(u_Sampler, 0);
    return initTexture(gl, "./img/ff.jpg")
  }).then(() => {
    let u_Sampler2 = gl.getUniformLocation(gl.program, 'u_Sampler2');
    gl.uniform1i(u_Sampler2, 1);
    gl.clear(gl.COLOR_BUFFER_BIT);   // Clear <canvas>

    gl.drawArrays(gl.TRIANGLE_STRIP, 0, n); // Draw the rectangle
  })
}

function initVertexBuffers(gl) {
  let verticesWithTexCoords = new Float32Array([
    -0.5, 0.5, 0.0, 1.0,
    -0.5, -0.5, 0.0, 0.0,
    //位置相反,Bug
    0.5, 0.5, 1.0, 1.0,
    0.5, -0.5, 1.0, 0.0,
  ])

  let n = 4;
  //创建缓冲区
  let verticesWithTexCoordBuffer = gl.createBuffer()
  let FSIZE = verticesWithTexCoords.BYTES_PER_ELEMENT;

  //gl激活缓冲区
  gl.bindBuffer(gl.ARRAY_BUFFER, verticesWithTexCoordBuffer)

  //绑定缓冲区数据
  gl.bufferData(gl.ARRAY_BUFFER, verticesWithTexCoords, gl.STATIC_DRAW)

  let a_Position = gl.getAttribLocation(gl.program, 'a_Position')

  gl.vertexAttribPointer(a_Position, 2, gl.FLOAT, false, FSIZE * 4, 0)
  gl.enableVertexAttribArray(a_Position)

  let a_TexCoord = gl.getAttribLocation(gl.program, 'a_TexCoord')
  gl.vertexAttribPointer(a_TexCoord, 2, gl.FLOAT, false, FSIZE * 4, FSIZE * 2)
  gl.enableVertexAttribArray(a_TexCoord)

  return n
}

let textures = [
  'TEXTURE0', 'TEXTURE1', 'TEXTURE2', 'TEXTURE3'
]
function initTexture(gl, imgSrc) {
  return new Promise((resolve, reject) => {
    let texture = gl.createTexture()
    if (!texture) {
      reject()
    }
    let image = new Image();
    image.onload = () => {
      //翻转T轴
      gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, 1)
      //激活纹理单元
      gl.activeTexture(gl[textures.shift()])
      //为纹理单元绑定纹理
      gl.bindTexture(gl.TEXTURE_2D, texture)

      //配置纹理参数
      gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR)

      //为纹理单元中的纹理绑定图像
      gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, image)
      resolve()
    }
    image.src = imgSrc
  })
}
