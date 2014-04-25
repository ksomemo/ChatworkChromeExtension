"use strict"

# livereload
path      = require('path')
lrSnippet = require('grunt-contrib-livereload/lib/utils').livereloadSnippet

# dir settings
dirApp    = "app"
dirDev    = "dev"
dirCoffee = "#{dirDev}/coffee"
dirSass   = "#{dirDev}/sass"
dirJs     = "#{dirApp}/js"
dirJsLib  = "#{dirJs}/lib"
dirCss    = "#{dirApp}/css"
dirBower  = "bower_components"

module.exports = (grunt) ->

  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  grunt.initConfig
    watch:
      options:
        livereload: true
      coffee:
        files: ["#{dirCoffee}/**/*.coffee", "#{dirSass}/**/*.sass"]
        tasks: ["default"]

    coffee:
      options:
        sourceMap: false
        join: false
      dist_multiple:
        expand: true
        flatten: false
        cwd: dirCoffee
        src: ["*.coffee"]
        dest: dirJs
        ext: ".js"

    sass:
      dist:
        files: [
          expand: true
          cwd: dirSass
          src: ["*.sass"]
          dest: dirCss
          ext: ".css"
        ]

    copy:
      lib:
        files: [
          {expand: true, flatten: true, src: "#{dirBower}/jquery/dist/jquery.min.js", dest: dirJsLib}
        ]

    clean:
      dist: [dirJs, dirCss]

    notify:
      success:
        options:
          message: "Success."

  grunt.registerTask 'default', [
    "clean"
    "coffee:dist_multiple"
    "sass:dist"
    "copy"
    "notify:success"
    "watch"
  ]
