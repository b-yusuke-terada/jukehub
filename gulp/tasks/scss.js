var config = require('./config');
var gulp = require('gulp');
var sass = require('gulp-sass');
var rename = require('gulp-rename');
var rev  = require('gulp-rev');
var minifyCss = require('gulp-minify-css');
var autoprefixer = require("gulp-autoprefixer");
var plumber = require("gulp-plumber");

gulp.task('compile-scss', function() {
  return gulp.src(config.stylesheet.srcScss)
      .pipe(plumber())
      .pipe(sass({ style: 'expanded' }).on('error', sass.logError))
      .pipe(autoprefixer())
      .pipe(minifyCss())
      .pipe(rename({ suffix: '.bundle' }))
      .pipe(gulp.dest(config.stylesheet.dest))
      .pipe(gulp.dest(config.publicAssets));
});

gulp.task('compile-image', function() {
  return gulp.src(config.image.src)
      .pipe(gulp.dest(config.image.dest))
});

// watch
gulp.task('watch-scss', function() {
    var watcher = gulp.watch('app/assets/**/*.scss', ['compile-scss']);
    watcher.on('change', function(event) {});
});
