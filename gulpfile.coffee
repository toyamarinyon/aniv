gulp   = require 'gulp'
coffee = require 'gulp-coffee'
sass   = require 'gulp-sass'
jade   = require 'gulp-jade'
webserver   = require 'gulp-webserver'

gulp.task 'default', ['build']
gulp.task 'build', [
  'build:coffee'
  'build:jade'
  'build:css'
]
gulp.task 'development', [
  'webserver'
  'build'
  'watch'
]

gulp.task 'build:coffee', ->
  gulp.src('src/assets/scripts/**/*.coffee')
    .pipe coffee
      bare: true
    .pipe gulp.dest('public/assets/scripts')

gulp.task 'build:jade', ->
  gulp.src('src/**/*.jade')
    .pipe jade()
    .pipe gulp.dest('public')

gulp.task 'build:css', ->
  gulp
    .src('src/assets/styles/**/**.sass')
    .pipe sass
      indentedSyntax: true
      includePaths:[
        "node_modules/font-awesome/scss/",
        "node_modules/bootstrap-sass/assets/stylesheets/"
      ]
    .pipe gulp.dest('public/assets/styles')

gulp.task 'copy:assets', ->
  gulp
    .src 'src/assets/fonts/**/**.ttf'
    .pipe gulp.dest 'public/assets/fonts'
  gulp
    .src 'vendor/ace-builds/src-min/**/**.js'
    .pipe gulp.dest 'public/assets/scripts/ace-builds'

gulp.task 'watch', ['build'], ->
  gulp.watch 'src/assets/scripts/**/*.coffee', ['build:coffee']
  gulp.watch 'src/**/*.jade', ['build:jade']
  gulp.watch 'src/assets/styles/**/**.sass', ['build:css']

gulp.task 'webserver', ->
  gulp.src './public'
    .pipe webserver
      livereload: true
      host: '0.0.0.0'
      directoryListening: true
