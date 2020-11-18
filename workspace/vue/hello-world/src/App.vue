<template>
  <div id="app">
    <InputPanel />
  </div>
</template>

<script>
import HelloWorld from './components/HelloWorld.vue';
import InputPanel from './components/InputPanel.vue';

export default {
  name: 'app',
  components: {
    HelloWorld,
    InputPanel,
  }
}
</script>

<style>
@import 'https://cdn.bootcss.com/semantic-ui/2.0.0/semantic.min.css';

#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
