let $ = r => document.querySelector(r)


function showPanel(btnId, targetId, closeId) {
    let btn = $(btnId)
    let target = $(targetId)
    btn.onclick = e => {
        target.style.visibility = "visible"
    }

    if (!!closeId) {
        let close = $(closeId)
        close.onclick = e => {
            target.style.visibility = "hidden"
        }
    }
}

showPanel("#show-work1", "#work1", "#work1-close");
showPanel("#show-work2", "#work2", "#work2-close");
showPanel("#show-work3", "#work3", "#work3-close");

function navTo() {
    let now = null
    
    return elem => {
        now && now.classList.remove("hover")
        elem && elem.classList.add("hover")
        now = elem
    }
}

let nav = navTo()

let navs = document.getElementsByTagName("nav")[0].children

Array.prototype.forEach.call(navs, e => {
    e.onclick = function() {
        nav(e)
    }
})