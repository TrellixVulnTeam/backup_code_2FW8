module.exports = {
    root: true,
    parser: 'vue-eslint-parser',
    parserOptions: {
        // 对 JavaScript 使用 babel-eslint \
        'parser': 'babel-eslint', 
        'ecmaVersion': 2017, 
        // 使用 import/export 语法 
        'sourceType': 'module'
    }, // 全局环境对象 
    env: {
        browser: true,
        es6: true,
        jest: true,
    },
    extends: [ 
        //https://github.com/feross/standard/blob/master/RULES.md#javascript-standard -style
        'standard',
        // https://github.com/vuejs/eslint-plugin-vue#bulb-rules 
        'plugin:vue/recommended',
    ],
    rules: {
        'no-use-before-define': 'off',
        'comma-dangle': ['error', 'always-multiline'],
    }

}