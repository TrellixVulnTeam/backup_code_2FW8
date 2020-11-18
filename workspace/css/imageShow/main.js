; (function() {

    let template = `
        <div class="image-container">
        </div>
    `

    let imgTemplate = `
        <div class="image">
            <img class="img" />
        </div>
    `
    
    //对DOM和图片建立关联,使得移除dom时也会移除图片
    function ImageManager() {
        this.imgDoms = new Map()
        this.container = covertToDom(template)
    }

    //添加DOM
    ImageManager.prototype.addImage = function (img) {
        let imgDom = covertToDom(imgTemplate)

        getElementsByClass(imgDom, "img")[0].setAttribute('src', img)

        this.imgDoms.set(imgDom, img)
        imgDom.addEventListener('click', e => {
            this.container.removeChild(imgDom)
            this.imgDoms.delete(imgDom)
        })

        this.container.appendChild(imgDom)
    }

    /**
     * @param {String} html_str  html字符串
     */
    function covertToDom(html_str) {
        let div = document.createElement('div')

        if (typeof html_str === 'string') {
            div.innerHTML = html_str
        }
        console.log(div, div.childNodes[0])
        return div.children[0]
    }

    function getElementsByClass(target, className) {
        let e = []
        _tags = target.getElementsByTagName("*")

        for (let tag of _tags) {
            if (!!tag.className && 
                typeof tag.className === 'string' &&
                tag.className.indexOf(className) > -1) {
                    e.push((tag))
                }
        }

        return e
    }

    _global = (function(){ return this || (0, eval)('this'); }());
    //NodeJS AMD模块系统
    if (typeof module !== "undefined" && module.exports) {
        module.exports = ImageManager;
    } else if (typeof define === "function" && define.amd) {
        define(function(){return ImageManager;});
    } else {
        !('ImageManager' in _global) && (_global.ImageManager = ImageManager);
    }
}())