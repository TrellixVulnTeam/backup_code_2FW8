function sequence(tasks) {
    let newVal = function(initArr, val) {
        initArr.push(val)
        return initArr
    }
    val = newVal.bind(null, [])

    return tasks.reduce((promise, task) => {
        return promise.then(task).then(val)
    }, Promise.resolve())
}