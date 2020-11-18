<template>
  <v-navigation-drawer v-model="drawer" fixed>
    <v-container fill-height style="padding: 0;">
      <v-layout column :wrap="false">
        <h2>文章列表</h2>
        <div style="flex:1;overflow: auto;">
          <v-list class="pa-1">
            <template v-for="item in articles">
              <v-list-tile :key="item.id" @click="selectedArticle(item);">
                <v-list-tile-content>
                  <v-list-tile-title>{{ item.title }}</v-list-tile-title>
                </v-list-tile-content>

                <v-list-tile-action>
                  <v-btn icon @click.stop="deleteArticle(item)">
                    <v-icon>delete</v-icon>
                  </v-btn>
                </v-list-tile-action>
              </v-list-tile>

              <v-divider :key="'_' + item.id"></v-divider>
            </template>
          </v-list>
        </div>
        <div>
          <v-btn block flat @click="createArticle">
            <v-icon color="red" left>add</v-icon>
            创建新文件
          </v-btn>
          <v-btn block flat @click="exportToMarkdownFile">
            <v-icon color="red" left>share</v-icon>
            导出为md文件
          </v-btn>
          <v-btn block flat @click="openAboutDialog">
            <v-icon color="green" left>info</v-icon>
            About
          </v-btn>
        </div>
      </v-layout>
    </v-container>
    <AboutDialogBox v-model="dialog" />
  </v-navigation-drawer>
</template>

<script>

import store from '../store'
import AboutDialogBox from "./AboutDialogBox"
export default {
  components: {
    AboutDialogBox
  },
  model: {
    prop: "show",
    event: "change"
  },
  props: ["show"],
  data() {
    return {
      drawer: null,
      dialog: false,
      action: store.action
    };
  },
  computed: {
    articles() {
      return store.data.articles
    }
  },
  watch: {
    drawer(val) {
      this.$emit("change", val);
    },
    show(val) {
      this.drawer = val;
    }
  },
  methods: {
    selectedArticle(article) {
      store.action.chooseArticle(article.id)
    },
    createArticle() {
      store.action.newArticle("")
    },
    deleteArticle(item) {
      this.action.deleteArticle(item)
    },
    exportToMarkdownFile() {
      let aTag = document.createElement('a')
      let blob = new Blob([store.getter.nowArticle.content])
      aTag.download = store.getter.nowArticle.title + ".md"
      aTag.href = URL.createObjectURL(blob)
      aTag.click()
      URL.revokeObjectURL(blob)
    },
    exportToPDFFile() {

    },
    openAboutDialog() {
      this.dialog = true
    }
  },
  async mounted() {
    // await this.$db.insertArticle(
    //   "hello world!",
    //   `
    //   IndexedDB是HTML5规范里新出现的浏览器里内置的数据库。对于在浏览器里存储数据，你可以使用cookies或local storage，但它们都是比较简单的技术，而IndexedDB提供了类似数据库风格的数据存储和使用方式。存储在IndexedDB里的数据是永久保存，不像cookies那样只是临时的。IndexedDB里提供了查询数据的功能，在online和offline模式下都能使用。你可以用IndexedDB存储大型数据。
    // `
    // );
  }
};
</script>

<style scoped>
*::-webkit-scrollbar {
  display: none;
}

h2 {
  padding: 1em;
}
</style>
