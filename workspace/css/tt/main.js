function isRequire(val) {
    return val.trim() !== "";
}

function isEmpty(val) {
    return val.trim() === "";
}

function isNumber(val) {
    return typeof val === 'number';
}

function isArray(val) {
    return val instanceof Array;
}

function isLength(arr) {
    return arr.length > 0;
}

function Minum(minVal) {
    return function(val) {
        return val >= minVal
    }
}

r = [isNumber, Minum(1)]
new Vue({
    el: "#app",
    data: {
        arr: [1,2,3,4],
        valid: [],
    },
    created() {
        this.$watch('arr', function(newVal, oldVal) {
            for (let i = 0; i < newVal.length; i++) {
                this.valid[i] = r.every(f => f(newVal[i]))
            }
        }, {
            immediate: true,
        })
    }
})