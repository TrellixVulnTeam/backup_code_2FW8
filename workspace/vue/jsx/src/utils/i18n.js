import VueI18n from 'vue-i18n'
import langs from '../../i18n'
import { timingSafeEqual } from 'crypto';

export async function createI18n (locale) {

    const { default: localeMessages } = await import(`../../i18n/locales/${locale}`);

    const messages  = {
        //解构赋值
        [locale] : localeMessages,
    }

    const i18n = new VueI18n({
        locale,
        messages,
    })
    console.log(localeMessages)
    return i18n
}

export function getAutoLang() {
    let result = window.navigator.userLanguage || window.navigator.language
    if (result) {
        result = result.substr(0, 2)
    }

    if (langs.indexOf(result) === -1) {
        return 'en'
    } else {
        return result;
    }
}

export async function setLocale(locale) {
    const { default: messages } = await import(`../../i18n/locales/${locale}`)
}