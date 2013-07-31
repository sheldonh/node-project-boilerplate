module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    clean:
      build:
        src: 'build/'
        force: true
      dist:
        src: 'lib/'
        force: true

    copy:
      dist:
        expand: true
        cwd: 'build/'
        src: 'lib/**/*.js'
        dest: '.'
      srcJs:
        expand: true
        cwd: 'src/'
        src: '**/*.js'
        dest: 'build/lib/'
      testJs:
        expand: true
        cwd: 'test/'
        src: '**/*.js'
        dest: 'build/test/'

    coffee:
      src:
        expand: true
        cwd: 'src/'
        src: '**/*.coffee'
        dest: 'build/lib'
        ext: '.js'
      test:
        expand: true
        cwd: 'test/'
        src: '**/*.coffee'
        dest: 'build/test'
        ext: '.js'

    mochaTest:
      test:
        src: 'build/test/**/*-test.js'
        options: {reporter: 'tap'}

    watch:
      srcCoffee:
        files: ['src/**/*.coffee']
        tasks: ['coffee:src', 'dist', 'mochaTest']
      srcJs:
        files: ['src/**/*.js']
        tasks: ['copy:srcJs', 'dist', 'mochaTest']
      testCoffee:
        files: ['test/**/*.coffee']
        tasks: ['coffee:test', 'mochaTest']

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-mocha-test'

  grunt.registerTask 'build',   'Build',                     ['coffee', 'copy:srcJs', 'copy:testJs']
  grunt.registerTask 'dist',    'Prepare distribution',      ['copy:dist']
  grunt.registerTask 'test',    'Test',                      ['mochaTest']
  grunt.registerTask 'default', 'Clean, build, dist & test', ['clean', 'build', 'dist', 'mochaTest']
