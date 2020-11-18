import { dbhelper } from "./articleDB"

const store = {
    data: {
        selected: -1,
        articles: [],
    },
    getter: {
        get articles() {
            return store.data.articles
        },

        //当前选中的文章
        get nowArticle() {
            if (store.data.selected < 0) {
                return null
            }

            return store.getter.articles.find(a => {
                return a.id == store.data.selected
            })
        },

        get selected() {
            return store.data.selected
        },


    },
    action: {
        async newArticle(title) {
            let newId = await dbhelper.insertArticle(title)
            await this.addToArticles(newId, "")
        },

        async addToArticles(id, content) {
            let article = {
                id: id,
                content: content
            }

            Object.defineProperty(article, "title", {
                get() {
                    let title = this.content && this.content.split("\n")[0]
                    if (!title.trim()) {
                        title = "未命名文档"
                    }
                    return title
                }
            })

            store.data.articles.push(article)

        },

        //选中当前所要操作的文章
        /**
         * 
         * @param {Number | Object} id  文章编号或者文章对象
         */
        async chooseArticle(id) {
            store.action.saveNowArticle()
            if (typeof(id) === 'number') {
                store.data.selected = id
            } else if (typeof(id) === 'object') {
                store.data.selected = id['id']
            }
        },

        async deleteArticle(item) {
            await dbhelper.deleteArticle(item.id)
            let index = store.getter.articles.findIndex(a => {
                return a.id === item.id
            })
            store.data.articles.splice(index, 1)
            await store.action.getExistArticle()
        },

        async saveNowArticle() {
            let article = store.getter.nowArticle
            if (!!article) {
                await dbhelper.updateArticle(article.id, article.content)
            }
        },

        /**
         * 选取一个存在的文章
         */
        async getExistArticle() {
            if (!store.getter.articles.length) {
                await store.action.newArticle("")
            }

            await store.action.chooseArticle(store.getter.articles[0])
        }
    },
    async init() {
        let articleDatas = await dbhelper.getAllArticle()
        for (let val of articleDatas) {
            store.action.addToArticles(val.id, val.content)
        }

        this.action.chooseArticle(parseInt(localStorage.getItem("selected")) || -1)

        /**
         * 自动保存文件
         */
        window.addEventListener('beforeunload', function () {
            store.action.saveNowArticle()
            localStorage.setItem("selected", store.getter.selected)
        })
        setInterval(store.action.saveNowArticle, 20000)
    }
}

export default store