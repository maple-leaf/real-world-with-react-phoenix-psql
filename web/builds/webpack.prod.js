const webpack = require("webpack");
const merge = require("webpack-merge");
const UglifyJSPlugin = require("uglifyjs-webpack-plugin");
const WebpackAssetsManifest = require("webpack-assets-manifest");
const GitRevisionPlugin = require("git-revision-webpack-plugin");
const http = require('http');

const common = require("./webpack.common.js");

const gitRevisionPlugin = new GitRevisionPlugin();

module.exports = merge(common, {
    output: {
        filename: "[name].[hash].js",
        path: distPath
    },
    plugins: [
        new UglifyJSPlugin({
            sourceMap: false
        }),
        new webpack.DefinePlugin({
            "process.env.NODE_ENV": JSON.stringify("production")
        }),
        new WebpackAssetsManifest({
            publicPath: "//cdn.mywebsite.com",
            output: `manifest-${gitRevisionPlugin
                .commithash()
                .slice(0, 10)}.json`,
            done: function(manifest) {
                const updateVersionReq = http.request({
                    hostname: 'localhost',
                    port: 4000,
                    path: `/?new_version=${JSON.stringify(manifest.assets)}`
                });
                updateVersionReq.end();
            }
        })
    ]
});
