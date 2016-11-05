var config = require('./config');
var gulp = require('gulp');
var sass = require('gulp-sass');
var rename = require('gulp-rename');
var rev  = require('gulp-rev');
var minifyCss = require('gulp-minify-css');

gulp.task('compile-sass', function() {
  return gulp.src(config.stylesheet.srcSass)
      .pipe(sass({ indentedSyntax: true, errLogToConsole: true }))
      .pipe(minifyCss())
      .pipe(rename({ suffix: '.bundle' }))
      .pipe(gulp.dest(config.stylesheet.dest))
      .pipe(gulp.dest(config.publicAssets));
});

gulp.task('compile-scss', function() {
  return gulp.src(config.stylesheet.srcScss)
      .pipe(sass({ indentedSyntax: false, errLogToConsole: true }))
      .pipe(minifyCss())
      .pipe(rename({ suffix: '.bundle' }))
      .pipe(gulp.dest(config.stylesheet.dest))
      .pipe(gulp.dest(config.publicAssets));
});

gulp.task('compile-image', function() {
  return gulp.src(config.image.src)
      .pipe(gulp.dest(config.image.dest))
});
