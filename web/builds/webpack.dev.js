/*
 * webpack.dev.js
 * webpack config for dev env
 *
 */
const merge = require("webpack-merge");
const common = require("./webpack.common.js");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const webpack = require("webpack");

module.exports = merge(common, {
    // Enable sourcemaps for debugging webpack's output.
    devtool: "source-map",

    devServer: {
        contentBase: "./dist",
        hot: true,
        port: 9000,
        headers: {
            "Access-Control-Allow-Origin": "http://localhost:4000",
            "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS"
        }
    },

    plugins: [
        new HtmlWebpackPlugin({
            template: "index.html",
            inject: "body"
        }),
        new webpack.NamedModulesPlugin(),
        new webpack.HotModuleReplacementPlugin()
    ]

    // externals: {
    //     "react": "React",
    //     "react-dom": "ReactDOM"
    // },
});
