const merge = require("webpack-merge")
const UgifyJsplugin = require("uglifyjs-webpack-plugin")
const webpack = require("webpack")

const common = require("./webpack.common.js")

module.exports = merge(common, {
    devtool: "source-map",
    plugins: [
        new webpack.optimize.UglifyJsPlugin({sourceMap: true}),
        new webpack.DefinePlugin({
            "process.env.NODE_ENV": JSON.stringify('production')
        }),
    ],
    mode: "production",
    
})