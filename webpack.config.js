"use strict";

const Path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");

const mode = process.env.NODE_ENV;

module.exports = {
  mode,
  ...(mode === "production"
    ? {
        devtool: "source-map",
      }
    : {
        devtool: "inline-source-map",
        devServer: {
          port: 4008,
          stats: "errors-only",
          contentBase: Path.resolve(__dirname, "dist"),
        },
      }),
  entry: "./src/index.js",
  output: {
    path: Path.resolve(__dirname, "dist"),
    ...(mode === "production"
      ? {
          filename: "[name].[chunkhash].min.js",
          sourceMapFilename: "[name].[chunkhash].map.js",
        }
      : {
          filename: "[name].js",
        }),
  },
  module: {
    rules: [
      {
        test: /\.purs$/,
        use: [
          {
            loader: "purs-loader",
            options: {
              spago: true,
              pscIde: true,
              src: "src/**/*.purs",
              watch: mode === "development",
              pscBundleArgs: { sourceMaps: true },
            },
          },
        ],
      },
      {
        test: /\.(png|jpg|gif)$/i,
        use: [{ loader: "url-loader" }],
      },
      {
        test: /\.css$/,
        use: ["style-loader", "css-loader"],
      },
    ],
  },
  resolve: {
    modules: ["node_modules"],
    extensions: [".purs", ".js"],
  },
  plugins: [
    new HtmlWebpackPlugin({
      title: "purescript-webpack-example",
      template: "assets/html/index.html",
    }),
  ],
};
