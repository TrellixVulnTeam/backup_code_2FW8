const path = require("path")
const CleanWebpackPlugin = require("clean-webpack-plugin")
const HtmlWebpaclPlugin = require("html-webpack-plugin")

module.exports = {
    entry: './src/main.js',
    output: {
        filename: '[name].bundle.js',
        path: path.resolve(__dirname, 'dist')
    },
    devtool: 'inline-source-map',
    devServer: {
        contentBase: './'
    },
    plugins: [
        new CleanWebpackPlugin(),
        new HtmlWebpaclPlugin({
            title: 'pixi fly',
        })
    ],
}