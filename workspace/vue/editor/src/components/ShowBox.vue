<template>
  <div v-follow class="editor" v-html="md_content"></div>
</template>

<script>
import marked from "marked";
export default {
  props: {
    content: String
  },
  computed: {
    md_content() {
      return marked(this.content);
    }
  }
};
</script>
<style scoped src="../styles/markdownstyle/markdown1.css"></style>
<style scoped>
iframe {
  border: none;
  width: 100%;
  height: 100%;
}

.editor {
  transition: all linear .2s;
}

.editor::-webkit-scrollbar {
  display: none;
}
/* @import url("../styles/markdownstyle/markdown1.css"); */
</style>
