IndexedDB需要封装为Promise的方法
打开数据库
创建表

增删改查
选定索引
查询

openDB("demo", 1)
.then(r => {
    db = r;
})
.catch(e => {
    throw Error
})