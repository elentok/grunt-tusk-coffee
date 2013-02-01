'use strict'

grunt = require('grunt')
expect = (require 'chai').expect

describe "commoncoffee task", ->

  describe "scenario1", ->
    it "should compile the coffeescripts into a single javascript file", ->
      actual = grunt.file.read('tmp/scenario1.js')
      expected = grunt.file.read('test/expected/scenario1.js')
      expect(actual).to.equal(expected)

#exports.commoncoffee =
  #setUp: (done) ->
    ## setup here if necessary
    #done()

  #default_options: (test) ->
    #test.expect(1)

    #actual = grunt.file.read('tmp/default_options') ->
    #expected = grunt.file.read('test/expected/default_options') ->
    #test.equal(actual, expected,
      #'should describe what the default behavior is.')

    #test.done()

  #custom_options: (test) ->
    #test.expect(1)

    #actual = grunt.file.read('tmp/custom_options')
    #expected = grunt.file.read('test/expected/custom_options')
    #test.equal(actual, expected,
      #'should describe what the custom option(s) behavior is.')

    #test.done()
    
