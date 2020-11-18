export default function (name) {
    let propName = "_" + name
    return {
        props: [propName],
        data() {
            let d = {}
            d[name] = this.$props[propName]
            return d
        },
        model: {
            prop: propName,
            event: "change",
        },
        created() {
            this.$watch(propName, function(val) {
                this.$data[name] = val
            })

            this.$watch(name, function(val) {
                this.$emit("change", val)
            })
        }
    }
}