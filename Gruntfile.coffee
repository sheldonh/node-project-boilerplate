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

    simplemocha:
      options:
        reporter: 'tap'
      all:
        src: 'build/test/**/*-test.js'

    justWatch:
      src:
        options:
          event: ['added', 'changed']
        files: ['src/**/*.{coffee,js}']
        tasks: ['coffee:src', 'copy:srcJs', 'dist', 'test']
      test:
        options:
          event: ['added', 'changed']
        files: ['test/**/*.{coffee,js}']
        tasks: ['coffee:test', 'copy:testJs', 'test']
      testDeletes:
        options:
          event: 'deleted'
        files: ['test/**/*.{coffee,js}']
        tasks: ['clean:build', 'coffee:test', 'copy:testJs', 'test']
      srcDeletes:
        options:
          event: 'deleted'
        files: ['src/**/*.{coffee,js}']
        tasks: ['clean', 'build', 'dist', 'test']

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-simple-mocha'

  grunt.registerTask 'build',   'Build',                     ['coffee', 'copy:srcJs', 'copy:testJs']
  grunt.registerTask 'dist',    'Prepare distribution',      ['copy:dist']
  grunt.registerTask 'test',    'Test',                      ['simplemocha']
  grunt.registerTask 'default', 'Clean, build, dist & test', ['clean', 'build', 'dist', 'test']

  grunt.renameTask   'watch',   'justWatch'
  grunt.registerTask 'watch',   'Clean, build, dist, test & watch', ['default', 'justWatch']
