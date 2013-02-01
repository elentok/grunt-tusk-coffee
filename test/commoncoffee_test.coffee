'use strict'

grunt = require 'grunt'
compile = require '../lib/compile'
expect = (require 'chai').expect

describe "commoncoffee task", ->

  it "should pass scenario1", ->
    prefix = compile('lib/require_runtime.coffee', bare: false)
    expected = prefix + grunt.util.linefeed + grunt.file.read('test/expected/scenario1.js')

    actual = grunt.file.read('tmp/scenario1.js')
    expect(actual).to.equal(expected)

  it "should pass scenario2", ->
    expected = grunt.file.read('test/expected/scenario2.js')
    actual = grunt.file.read('tmp/scenario2.js')
    expect(actual).to.equal(expected)

  it "should pass scenario3", ->
  it "should compile the coffeescripts into a single javascript file", ->
    expected = grunt.file.read('test/expected/scenario3.js')
    actual = grunt.file.read('tmp/scenario3.js')
    expect(actual).to.equal(expected)
