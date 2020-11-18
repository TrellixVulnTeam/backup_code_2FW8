<template>
  <div id="app">
    <header>
      <h1>JWT DEMO</h1>
    </header>

    <NavMenu/>
    <transition name="fade" mode="out-in">
      <router-view></router-view>
    </transition>
  </div>
</template>

<script>
import NavMenu from "./components/NavMenu.vue";
export default {
  name: "app",
  data() {
    return {
      msg: "Welcome to Your Vue.js App"
    };
  },
  components: {
    NavMenu
  }
};
</script>

<style>

  #app {
    width: 768px;
    margin: 0 auto;
  }

  header {
    padding: 1px;
    background: #ec6d71;
  }

  h1 {
    margin: .4em;
    color: white;
  }

  .fade-enter, .fade-leave-to {
    opacity: 0;
  }

  .fade-enter-active, .fade-leave-active {
    transition: all .2s;
  }

</style>
