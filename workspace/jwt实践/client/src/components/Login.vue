<template>
    <main class="login">
        <h3>登录</h3>
        <input class="block-input" v-model="username" placeholder="用户名" type="text" />
        <input class="block-input" v-model="password" placeholder="密码" type="text" />
        <button @click="login">Login</button>
    </main>
</template>
<script>
export default {
    data() {
        return {
            username: "linda",
            password: "123",
        }
    },
    methods: {
        async login() {
            const data = await this.$fetch("login", {
                method: 'POST',
                body: this.loginData,
            });
            localStorage.setItem("user", data.token)
            this.$router.replace({name: "home"})
        }
    },
    computed: {
        loginData() {
            return JSON.stringify({
                username: this.username,
                password: this.password
            });
        }
    },
}
</script>
<style scoped>
    .login {
        text-align: center;
    }

    .login > input, button, textarea {
        width: 200px;
        margin: 1em auto;
        padding: .4em 1em;
    }

    h3 {
        font-weight: bold;
        margin: .8em 0;
    }

    .block-input {
        display: block;
        border-radius: 4px;
        border: 1px solid #666;
        outline: none;
        box-sizing: border-box;
    }

    button {
        background: #ec6d71;
        border: none;
        outline: none;
        color: white;
        cursor: pointer;
    }

    button:active {
        transform: translate(2px, 2px);
    }
</style>