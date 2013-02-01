#
# grunt-commoncoffee
# https:#github.com/elentok/grunt-commoncoffee
#
# Copyright (c) 2013 David Elentok
# Licensed under the MIT license.
#


'use strict'

module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    jshint:
      all: [ 'Gruntfile.js', 'tasks/*.js' ]
      options: { jshintrc: '.jshintrc', }

    # Before generating any new files, remove any previously-created files.
    clean:
      tests: ['tmp']

    # Configuration to be run (and then tested).
    commoncoffee:
      scenario1:
        options:
          root: 'test'
        files:
          'tmp/scenario1.js': ['test/fixtures/**/*.coffee']

    simplemocha:
      all: ['test/**/*_test.coffee']
      options:
        globals: ['window']
        reporter: 'spec'
        ui: 'bdd'

  # Actually load this plugin's task(s).
  grunt.loadTasks('tasks')

  # These plugins provide necessary tasks.
  grunt.loadNpmTasks('grunt-contrib-jshint')
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-simple-mocha')

  # Whenever the "test" task is run, first clean the "tmp" dir, then run this
  # plugin's task(s), then test the result.
  grunt.registerTask('test', ['clean', 'commoncoffee', 'simplemocha'])

  # By default, lint and run all tests.
  grunt.registerTask('default', ['jshint', 'test'])

