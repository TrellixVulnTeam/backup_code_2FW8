function promisify(func) {
    return function() {
        return new Promise((resolve, reject) => {
            let request = func()
            request.onsuccess = e => resolve(e)
            request.onerror = e => reject(e)
        })
    }
}

promisify(indexedDB.open) 