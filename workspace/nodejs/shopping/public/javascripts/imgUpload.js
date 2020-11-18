window.onload = function () {
  let img = document.querySelector('#preview')
  let upload = document.querySelector('#upload')
  previewImage(img, upload)
}

function previewImage(img, upload) {
  upload.addEventListener('change', e => {
    let file = upload.files[0]
    var reader = new FileReader();
    reader.readAsDataURL(file);
    //监听文件读取结束后事件
    reader.onloadend = function (e) {
      img.src = e.target.result
    };
  })
}