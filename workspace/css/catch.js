function getRes(code = 200) {
    if (code == 200) {
        return {
            "title": "使用 Fetch",
            "content": "Fetch API 提供了一个 JavaScript接口，用于访问和操纵HTTP管道的部分，例如请求和响应。它还提供了一个全局 fetch()方法，该方法提供了一种简单，合理的方式来跨网络异步获取资源。"
        }
    } else if (code == 403) {
        return {
            "msg": "请先登录"
        }
    } else {
        throw new Error("错误")
    }
}

function gets(code = 200) {
    const data = getRes(code)

    console.log(data)
}