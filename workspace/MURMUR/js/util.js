const MODE = {
    TIMERS: 1001,
    MIXES: 1002,
    SHARE: 1003,
}

function timeFormat(seconds) {
    let hour = "00" + Math.floor(seconds / 3600)
    let minute = "00" + Math.floor(seconds % 3600 / 60)
    let second = "00" + Math.floor(seconds % 60)

    return `${hour.slice(-2)}:${minute.slice(-2)}:${second.slice(-2)}`
}

function objectStrToArray(objStr) {
    obj = JSON.parse(objStr)
    arr = []
    for (let key in obj) {
        arr.push([
            key,
            obj[key]
        ])
    }

    return arr
}

function arrayToObjectStr(arr) {
    object = {}
    for (let value in arr) {
        object[arr[0]] = arr[1]
    }

    return JSON.stringify(object)
}

let audios = []