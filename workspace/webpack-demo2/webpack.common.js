const path = require('path');
const CleanWebpackPlugin = require('clean-webpack-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
    entry: {
        app: "./src/index.js",
        print: "./src/print.js"
    },

    output: {
        filename: "[name].bundle.js",
        path: path.resolve(__dirname, "dist")
    },

    plugins: [
        new CleanWebpackPlugin(),
        new HtmlWebpackPlugin({
            title: 'production',
        })
    ],
    optimization: {
      splitChunks: {
        chunks: 'all'
      }
    }
}