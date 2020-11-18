let request = window.indexedDB.open("demo", 1)

let db;
request.onerror = s => {
    console.log("数据库错误!");
}

request.onsuccess = s => {
    db = request.result
    console.log(request)
    console.log(db)
    console.log("数据库打开成功");
    // add({
    //     name: "sam",
    // })
    // add({
    //     name: "james",
    // })
    // add({
    //     name: "duku",
    // })
    // read()
    // readAll()
    findByName("james")
    // remove(4)
}

request.onupgradeneeded = e => {
    db = e.target.result
    objectStore = db.createObjectStore('person', { keyPath: 'id', autoIncrement: true });
    objectStore.createIndex('name', 'name', { unique: false })
}

function add(obj) {
    let request = db.transaction(['person'], 'readwrite')
        .objectStore('person')
        .add(obj)
    request.onsuccess = function (event) {
        console.log('数据写入成功');
    };

    request.onerror = function (event) {
        console.log('数据写入失败');
    }
}

function read() {
    let request = db.transaction(['person'], 'readwrite')
        .objectStore('person')
        .get(1)

    request.onsuccess = function (event) {
        if (request.result) {
            console.log(request.result);
            console.log('数据读取成功');
        } else {
            console.log('数据读取失败');
        }
    };

    request.onerror = function (event) {
        console.log('数据读取失败');
    }
}

function readAll() {
    let request = db.transaction(['person'], 'readwrite')
        .objectStore('person')
        .openCursor()

    request.onsuccess = function (event) {
        var cursor = event.target.result;
        if (cursor) {
            console.log(cursor.value)
            cursor.continue()
        }
    };
}


function remove(num) {
    let request = db.transaction(['person'], 'readwrite')
        .objectStore('person')
        .delete(num)

    request.onsuccess = function (event) {
        console.log('数据删除成功');
    };

    request.onerror = function (event) {
        console.log('数据删除失败');
    }
}

function findByName(name) {
    let request = db.transaction(["person"], "readonly")
                    .objectStore("person")
                    .index("name")
                    .get(name)
    console.log(request)
    request.onsuccess = e => {
        let result = e.target.result

        console.log(result)
    }
}
