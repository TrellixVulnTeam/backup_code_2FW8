import "babel-polyfill"
import Vue from "vue"
import App from "./components/App.vue"
import { createI18n, getAutoLang } from "./utils/i18n"
import "./plugins"

async function main() {
    const locale = getAutoLang()
    console.log(locale)

    const i18n = await createI18n(locale)

    new Vue({
        el: "#app",
        ...App,
        i18n,
    })
}

main()
