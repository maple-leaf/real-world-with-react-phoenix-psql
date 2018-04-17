const path = require("path");
const CleanWebpackPlugin = require("clean-webpack-plugin");

const distPath = path.resolve(__dirname, "../dist");

module.exports = {
    entry: {
        app: "./src/index.tsx"
    },
    output: {
        filename: "[name].[hash].js",
        path: distPath
    },
    plugins: [new CleanWebpackPlugin([distPath])],
    resolve: {
        // Add '.ts' and '.tsx' as resolvable extensions.
        extensions: [".ts", ".tsx", ".js", ".json"]
    },
    module: {
        rules: [
            { test: /\.(ts|tsx)?$/, loader: "awesome-typescript-loader" },

            // All output '.js' files will have any sourcemaps re-processed by 'source-map-loader'.
            { enforce: "pre", test: /\.js$/, loader: "source-map-loader" }
        ]
    }
};
