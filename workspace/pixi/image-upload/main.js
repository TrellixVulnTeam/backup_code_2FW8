;(function(undefined) {
    const itemTmpl = imgUrl => `
        <img src="${imgUrl}" />
    `

    //上传的图片集合
    let imgs = []

    const ImagesShow = {
        addImage(imageUrl) {
            const item = parseToDom(itemTmpl(imageUrl))
            imgs.push(item)
            item.addEventListener('click', e => {
                this.removeImage(item)
            })

            return item
        },
    
        /**
         * @param {HTMLElement} image 
         */
        removeImage(image) {
            const index = imgs.indexOf(image)
            if (index > -1) {
                image.parentElement.removeChild(image)
                imgs.splice(index, 1)
            }
        }
    }
    

    function parseToDom(str) {
        const dom = document.createElement("div")

        if (typeof str == 'string') {
            dom.innerHTML = str
        }

        return dom.children[0]
    }

    _global = (function(){ return this || (0, eval)('this'); }());
    if (typeof module !== "undefined" && module.exports) {
        module.exports = ImagesShow;
    } else if (typeof define === "function" && define.amd) {
        define(function(){return ImagesShow;});
    } else {
        !('ImagesShow' in _global) && (_global.ImagesShow = ImagesShow);
    }
}())