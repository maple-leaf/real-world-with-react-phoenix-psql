const webpack = require("webpack");
const merge = require("webpack-merge");
const UglifyJSPlugin = require("uglifyjs-webpack-plugin");
const WebpackAssetsManifest = require("webpack-assets-manifest");
const GitRevisionPlugin = require("git-revision-webpack-plugin");

const common = require("./webpack.common.js");

const gitRevisionPlugin = new GitRevisionPlugin();

module.exports = merge(common, {
    plugins: [
        new UglifyJSPlugin({
            sourceMap: false
        }),
        new webpack.DefinePlugin({
            "process.env.NODE_ENV": JSON.stringify("production")
        }),
        new WebpackAssetsManifest({
            publicPath: "//cdn.doubtv.com/real-world",
            output: `manifest-${gitRevisionPlugin
                .commithash()
                .slice(0, 10)}.json`
        })
    ]
});
