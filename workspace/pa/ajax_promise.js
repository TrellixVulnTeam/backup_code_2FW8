function getURL(url) {
    return new Promise((resolve, reject) => {
        let req = new XMLHttpRequest()
        req.open("GET", url, true)
        req.onload = function () {
            if (req.status == 200) {
                resolve(req.responseText)
            } else {
                reject(new Error(req.statusText))
            }
        }

        req.onerror = function () {
            reject(new Error(req.statusText))
        }

        req.send()
    })
}

function exValue(arrs, newValue) {
    arrs.push(JSON.parse(newValue))
    return arrs
}

let actions = {
    getA() {
        return getURL("http://localhost:8080/ax.json")
    },
    getB() {
        return getURL("http://localhost:8080/ax.json") 
    },
}

function main(callback) {
    let val = exValue.bind(null, [])
    actions.getA()
    .then(val)
    .then(actions.getB)
    .then(val)
    .then(callback)
}

main(s => console.log(s))

// get("http://localhost:8080/data.json").then(s => {
//     console.log(s)
// }).catch(e => {
//     console.log(e)    
// })