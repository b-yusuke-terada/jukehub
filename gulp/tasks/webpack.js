// gulp/tasks/webpack.js
var config        = require('./config');
var gulp          = require('gulp');
var webpack       = require('gulp-webpack');
var webpackConfig = require('./webpack.config.js');
var rev           = require('gulp-rev');

gulp.task('webpack', function() {
  return gulp.src(config.javascript.src)
      .pipe(webpack(webpackConfig))
      .pipe(gulp.dest(webpackConfig.output.publicPath))
});
