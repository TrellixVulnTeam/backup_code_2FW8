let baseUrl;

export async function $fetch(url, options) {
    const finalOptions = Object.assign({}, {
        headers: {
            'Content-Type': 'application/json',
            "Authorization": localStorage.getItem("user"),
        },
    }, options);

    let res = await fetch(`${baseUrl}${url}`, finalOptions)

    if (res.ok) {
        return await res.json()
    } else {
        let msg = await res.text()
        throw new Error(msg)
    }
}

export default {
    install(Vue, options) {
        baseUrl = options.baseUrl;
        Vue.prototype.$fetch = $fetch;
    }
}