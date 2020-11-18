this.addEventListener('message', e => {
    let data  = e.data
    console.log("接受到主线程消息:", data)
})