
class ImageManager {
    constructor(collect_elem) {
        //存储所有的已加载图片资源
        this.collect = collect_elem
        this.photos = []
        this.reader = new FileReader()
        this.reader.addEventListener('load', this.onLoad.bind(this))
    }

    addPhoto(img) {
        this.photos.push(img)
        let photo = document.createElement("div")
        photo.classList.add("photo")

        let close = document.createElement("span")
        close.classList.add("close")
        let i = this.photos.length - 1
        close.addEventListener('click', () => {
            this.collect.removeChild(photo)
            this.photos.splice(i, 1)
        })
        photo.appendChild(close)
        photo.style.backgroundImage = "url(" + img + ")";

        this.collect.appendChild(photo)
    }

    loadImage(file) {
        this.reader.readAsDataURL(file)
    }

    onLoad(e) {
        this.addPhoto(e.target.result)
    }
}

let manager = new ImageManager(document.querySelector("#container"))
let fileInput = document.querySelector("#file")
fileInput.addEventListener('change', e => {
    for (let file of fileInput.files)
        manager.loadImage(file)
})