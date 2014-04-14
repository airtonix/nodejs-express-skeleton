module.exports = (grunt) ->

  require('matchdep').filter('grunt-*').forEach(grunt.loadNpmTasks)

  path = require("path")

  @paths =
    build: "./build"
    dist: "./dist"
    src: "./src"

  images_regex = /(img\/[\w\d-]*\.(png|jpg|jpeg|gif))/
  api_regex = /(api\/.*\/[\w\d-]*\.json)/
  fonts_regex = /(fonts\/[\w\d-]*\.(eot|ttf|otf|woff|svg))/
  scripts_regex = /(js\/[\w\d-]*\.js)/


  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'
    bower: grunt.file.readJSON 'bower.json'

    paths: @paths

    coffee:
      build:
        options:
          sourceMap: true
          sourceMapDir: '<%= paths.build %>/assets/maps/'
        files: [
          expand: true
          cwd: '<%= paths.src %>/assets/js'
          src: '**/*.coffee'
          dest: '<%= paths.build %>/assets/js'
          ext: '.js'
        ]

    sass:
      options:
        includePaths: [
          'bower_components/'
          '<%= paths.src %>/assets/'
        ]
      build:
        files: {
          "<%= paths.build %>/assets/css/screen.css": "<%= paths.src %>/assets/css/screen.scss"
        }

    copy:
      build:
        files: [
          expand: true
          cwd: '<%= paths.src %>/assets'
          dest: '<%= paths.build %>/assets'
          src: [
            'img/**/*.{jpg,jpeg,gif,png,webp}'
            'fonts/**/*.{ttf,eot,otf,woff,svg}'
          ]
        ]

      dist:
        files: [
          expand: true
          cwd: '<%= paths.build %>/assets'
          dest: '<%= paths.dist %>/assets'
          src: [
            '**/*.css'
            '**/*.js'
            '**/*.{jpg,jpeg,gif,png,webp}'
            '**/*.{ttf,eot,otf,woff,svg}'
          ]
        ]

    jade:
      build:
        files: [
          expand: true
          cwd: '<%= paths.src %>/assets/js'
          dest: '<%= paths.build %>/assets/js'
          ext: '.tpl.html'
          src: [
            '**/*.jade'
          ]
        ]

    html2js:
      options:
        module: "app.templates"
        indentString: ''
        htmlmin:
          collapseWhitespace: true

      dist:
        options:
          base: "<%= paths.build %>/assets/"
          rename: (name) ->
            '/' + name
        src: ['<%= paths.build %>/assets/js/**/templates/**/*.html']
        dest: '<%= paths.build %>/assets/js/templates.js'

    requirejs:
      options:
        wrap: true
        almond: true
        preserveLicenseComments: false
        mainConfigFile: "<%= paths.build %>/assets/js/boot.js"
        name: 'boot'
        urlArgs: 'v=<%= pkg.version %>'
        out: "<%= paths.dist %>/assets/js/application.js"

      test:
        options:
          optimize: "none"

      dist:
        options:
          optimize: "uglify"

    filerev:
      options:
        encoding: 'utf8'
        algorithm: 'md5'
        length: 8
        copy: false

      build:
        files: [
          expand: true
          cwd: '<%= paths.build %>/assets'
          dest: '<%= paths.dist %>/assets'
          src: [
            'js/**/*.js'
            'js/**/*.html'
             'img/**/*.{jpg,jpeg,gif,png,webp}'
           'css/**/*.css'
            'fonts/**/*.{ttf,eot,otf,woff,svg}'
            'api/**/*.json'
          ]
        ]

    userev:
      options:
        hash: /([a-f0-9]{8})\.[a-z]+$/

      application:
        src: '<%= paths.dist %>/assets/js/**/*.js'
        options:
          patterns:
            'Data': api_regex
            'Images': images_regex

      styles:
        src: '<%= paths.dist %>/assets/css/**/*.css'
        options:
          patterns:
            'Images': images_regex
            'Fonts': fonts_regex

      views:
        src: '<%= paths.dist %>/views/**/*.html'
        options:
          patterns:
            'Scripts': scripts_regex
            'Images': images_regex

    shell:
      report:
        command: 'node colony'

    clean:
      build:
        src: ["<%= paths.build %>"]

      dist:
        src: ["<%= paths.dist %>"]

    bump:
      options:
        files: ['package.json', 'bower.json']
        updateConfigs: ['pkg', 'bower']
        createTag: true
        commit: true
        push: true

      develop:
        options:
          pushTo: 'origin develop'

      heroku:
        options:
          pushTo: 'heroku master'

  grunt.registerTask 'default', [
    'serve'
  ]

  grunt.registerTask 'serve', () ->
    async = this.async()
    ServerKlass = require "./src/server/test.coffee"
    server = new ServerKlass()

  grunt.registerTask 'build', [
    'clean'
    'copy:build'
    'coffee:build'
    'sass:build'
    'jade:build'
  ]

  grunt.registerTask 'dist', [
    'build'
    'html2js:dist'
    'requirejs:dist'
    'filerev:dist'
    'userev:dist'
    'copy:dist'
    'clean:build'
  ]

  grunt.registerTask 'test', [
    'build'
    'serve'
  ]