function notifyMessage(msg, options, callback) {

    if (Notification && Notification.permission == "granted") {
        notify = new Notification(msg, options)
        callback(null, notify)
    } else if (Notification.requestPermission) {
        Notification.requestPermission(function(status) {
            if (Notification.permission !== status) {
                Notification.permission = status
            }
            
            if (Notification.permission == "granted") {
                notify = new Notification(msg, options)
                callback(null, notify)
            } else {
                callback(new Error("not permission"), null)
            }
        })
    } else {
        callback(new Error("not permission"), null)
    }
}

notifyMessage("hello!", {}, (error, notify) => {
    if (error) {
        console.log(error)
    }
    console.log(notify)
})