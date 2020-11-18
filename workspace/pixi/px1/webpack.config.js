const path = require('path')
const htmlWebpackPlugin = require('html-webpack-plugin')
const cleanWebpackPlugin = require('clean-webpack-plugin')
module.exports = {
    entry: {
        app: './src/main.js',
    },
    output: {
        filename: '[name].bundle.js',
        path: path.resolve(__dirname, 'dist')
    },
    'devtool': 'inline-source-map',
    devServer: {
        contentBase: './dist'
    },
    plugins: [
        new cleanWebpackPlugin(),
        new htmlWebpackPlugin({
            title: 'Pixi Demo'
        }),
        
    ],
    module: {
        rules: [
            {
                test: /\.css$/,
                use: [
                    'style-loader',
                    'css-loader'
                ]
            },
            {
                test: /\.(png|jpg)$/,
                use: [
                    'file-loader'
                ]
            },
        ]
    }
}