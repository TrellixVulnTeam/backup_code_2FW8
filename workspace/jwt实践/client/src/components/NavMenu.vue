<template>
  <nav class="menu">
    <router-link class="showline" :to="{name: 'home'}" exact>Home</router-link>
    <router-link class="showline" :to="{name: 'news'}" exact>News</router-link>
    <router-link class="showline" :to="{name: 'login'}" exact>Login</router-link>
    <a @click="logout" class="showline right">Logout</a>
  </nav>
</template>
<script>
export default {
    methods: {
        logout() {
            localStorage.removeItem("user")
            this.$router.replace({name: "login"})
        }
    }
}
</script>
<style>
.menu {
  font-size: 1.4em;
  color: #5383c3;
}

.menu::after {
  content: " ";
  display: block;
  clear: both;
  visibility: hidden;
}

.menu > a,a:link,
a:visited,
a:hover,
a:active {
  padding: 1em 0;
  color: inherit;
  text-decoration: none;
  margin-right: .6em;
  vertical-align: middle;
}

.showline {
  display: inline-block;
  cursor: pointer;
}

.showline::after {
  content: " ";
  width: 100%;
  height: 2px;
  background: black;
  display: block;
  transform: scaleX(0);
  transition: 0.2s ease-in-out;
}

.showline:hover::after {
  transform: scaleX(1);
}

.right {
    float: right;
}
</style>

