/**
 * @param {String} tagName 标签名称
 * @param {Object} propertys 节点属性
 * @param {Obejct or String or Array} 
 */
function h(tagName, propertys, childs) {
    let elem = document.createElement(tagName)
    
    !childs && (childs = [])

    !propertys && (propertys = [])

    for (let prop in propertys) {
        elem.setAttribute(prop, propertys[prop])
    }

    for (let child of childs) {
        console.log(child)
        elem.appendChild(handleChild(child))
    }

    return elem
}

function handleChild(child) {

    if (Object.prototype.toString.call(child) === '[object String]') {
        return document.createTextNode(child)
    }

    return child
}