const $ = r=>document.querySelector(r)

let fileInput = $("#file")
let img = $("#preview")
let reader = new FileReader()

fileInput.addEventListener('change', function(e) {
    let file = fileInput.files[0]

    reader.onload = function(e) {
        img.src = e.target.result
    }
    reader.readAsDataURL(file)
})