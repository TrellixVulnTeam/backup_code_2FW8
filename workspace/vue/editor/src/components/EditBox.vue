<template>
  <div class="editor flex" v-follow.master>
    <div class="line-state">
      <div v-for="line in lines" :key="line">
        {{line}}
      </div>
    </div>
    <div style="flex:1;">
      <div class="content" @input="change" contenteditable="nowArticle"></div>
    </div>
  </div>
</template>

<script>
import store from "../store"
export default {
  model: {
    prop: "content",
    event: "change"
  },
  props: {
    content: String
  },
  data() {
    return {
      store: store,
    }
  },
  methods: {
    change(event) {
      this.$emit("change", event.target.innerText);
    }
  },
  computed: {
    //总行数
    lines() {
      let arr = this.content.match(/\n/gim)
      let len =  arr ? arr.length + 1 : 1
      if (this.content.endsWith('\n')) {
        len--
      }
      return len
    },
    nowArticle() {
      return store.getter.nowArticle
    }
  },
  watch: {
    nowArticle(val, oldVal) {
      /**
       * 若当前文章为null
       */
      if (!val) {
        return
      }
      if (!oldVal || val.id !== oldVal.id){
        this.$emit("change", val.content)
        document.querySelector(".content").innerHTML = val.content
      }
    },
    content(val) {
      this.nowArticle.content =val
    }
  }
};
</script>

<style scoped>
.editor {
  overflow-y: scroll;
  font-size: 1.2em;
  line-height: 1.5em;
}

.content {
  word-break: break-all;
  height: 100%;
  outline: none;
  background-color: inherit;
  -webkit-user-modify: read-write-plaintext-only;
}

.flex {
  display: flex;
  height: 100%;
}

.line-state {
  font-size: .6em;
  padding: 0 1em;
  text-align: right;
  background-color: #f3f3f3;
  min-width: 4em;
}
</style>
