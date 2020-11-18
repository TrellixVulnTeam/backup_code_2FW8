import { openDB } from "idb"

const tablename = "article"

const db = openDB('mdmd', 1, {
    upgrade(db) {
        db.createObjectStore(tablename, { keyPath: 'id', autoIncrement: true })
    }
})

export const dbhelper = {

    /**
     * 
     * @param {String} content 
     */
    async insertArticle(content) {
        return (await db).add(tablename, {
            content: content
        })
    },
    /**
     * 
     * @param {Number} id 
     */
    async deleteArticle(id) {
        return (await db).delete(tablename, id)
    },
    /**
     * 
     * @param {Number} id 
     * @param {String} content 
     */
    async updateArticle(id, content) {
        //文章的title是由content的第一行确定的
        return (await db).put(tablename, {
            id: id,
            content: content,
        })
    },
    async getAllArticle() {
        let articles = await (await db).getAll(tablename)
        return articles
    }
}

export default function install(Vue, options) {
    Vue.prototype.$db = db
}