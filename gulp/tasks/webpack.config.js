// gulp/taks/webpack.config.js
//
var path = require('path');
var webpack = require('webpack');
var config = require('./config');

module.exports = {
  devtool: 'source-map',
  debug: true,
  entry: {
    application: './' + config.gulpAssets + '/javascripts/application'
  },
  output: {
    filename:   '[name].bundle.js',
    publicPath: config.javascript.dest
  },
  resolve: {
    extensions: ['', '.js', 'jsx']
  },
  module: {
    loaders: [
      { test: /\.vue$/,       loader: 'vue' },
      { test: /\.png$/,       loader: 'url?limit=8192' },
      { test: /\.css$/,       loader: "style!css" },
      { test: /\.scss$/,      loaders: ["style", "css", "scss"] },
      { test: /\.(otf|eot|svg|ttf|woff|woff2)(\?.+)?$/, loader: 'url' }
    ]
  }
};
