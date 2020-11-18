let editorRuntime;
let scene;
function setup() {
  createCanvas(800, 800);
  scene = new Scene(100, 100);
  editorRuntime = new EditorRun(scene);
}

function draw() {
  background(128);
  editorRuntime.update();
}

const widthInput = document.querySelector("#width");
const heightInput = document.querySelector("#height");
const changeBtn = document.querySelector("#changeBtn");
changeBtn.addEventListener('click', () => {
  scene.width = parseInt(widthInput.value);
  scene.height = parseInt(heightInput.value);
});