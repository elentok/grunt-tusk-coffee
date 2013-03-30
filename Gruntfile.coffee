#
# grunt-tusk-coffee
# https:#github.com/elentok/grunt-tusk-coffee
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
    tusk_coffee:
      scenario1:
        options:
          modulesRoot: 'test'
          runtime: true
        files:
          'tmp/scenario1.js': ['test/fixtures/**/*.coffee']

      scenario2: #don't add the 'require' method code
        options:
          modulesRoot: 'test/fixtures'
        files:
          'tmp/scenario2.js': ['test/fixtures/**/*.coffee']

      scenario3: #useful for vendor files
        options:
          modulesRoot: 'test/fixtures'
          wrap: false
        files:
          'tmp/scenario3.js': ['test/fixtures/**/*.coffee']

      scenario4: #don't join files
        options:
          modulesRoot: 'test/fixtures'
          join: false
          wrap: false
        files:
          'tmp/scenario4/': ['test/fixtures/**/*.coffee']

      scenario5: #wrap in function
        options:
          modulesRoot: 'test/fixtures'
          runtime: false
          wrap: 'Function'
        files:
          'tmp/scenario5.js': ['test/fixtures/**/*.coffee']

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
  grunt.registerTask('test', ['clean', 'tusk_coffee', 'simplemocha'])

  # By default, lint and run all tests.
  grunt.registerTask('default', ['jshint', 'test'])

