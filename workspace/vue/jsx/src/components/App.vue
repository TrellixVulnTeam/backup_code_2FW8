<template>
    <div id="app">
        <h1>App Vue</h1>
        <h3>{{ $t('change-lang') }}</h3>
        <span>{{ $t('back') }}</span>
        <div v-for="lang of langs"  :key="lang">
            <button @click="setLocale(lang)">
                {{ $t(`lang.${lang}`) }}
            </button>
        </div>
        <Para message="hello vue!" />
        <Comment v-for="(comment, index) in cs" :key="index" :content="comment" />
    </div>
</template>

<script>
import Para from "./Para"
import Comment from "./Comment"
import langs from "../../i18n"
export default {
    data() {
        return {
            langs,
            cs: [
                "hello world!",
                "ok dokey!",
                "Peacock !",
                "VS Code",
                "Web Storm",
            ]
        }
    },
    components: {
        Para,
        Comment
    },
    methods: {
        async setLocale(locale) {
            const { default: messages } = await import(`../../i18n/locales/${locale}`)
            console.log(messages)
            this.$i18n.setLocaleMessage(locale, messages)
            this.$i18n.locale = locale
        }
    }
}
</script>

<style>

</style>
