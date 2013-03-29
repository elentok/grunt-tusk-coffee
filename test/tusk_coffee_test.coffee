'use strict'

grunt = require 'grunt'
compile = require '../lib/compile'
expect = (require 'chai').expect

describe "tusk_coffee task", ->

  it "should pass scenario1", ->
    prefix = compile('lib/require_runtime.coffee', bare: false)
    expected = prefix + grunt.util.linefeed +
      grunt.file.read('test/expected/scenario1.js')

    actual = grunt.file.read('tmp/scenario1.js')
    expect(actual).to.equal(expected)

  it "should pass scenario2", ->
    expected = grunt.file.read('test/expected/scenario2.js')
    actual = grunt.file.read('tmp/scenario2.js')
    expect(actual).to.equal(expected)

  it "should pass scenario3", ->
    expected = grunt.file.read('test/expected/scenario3.js')
    actual = grunt.file.read('tmp/scenario3.js')
    expect(actual).to.equal(expected)

  it "allows not joining files", ->
    file1 = grunt.file.read('tmp/scenario4/file1.js')
    file2 = grunt.file.read('tmp/scenario4/file2.js')
    expect(file1).to.equal "var x;\n\nx = 1;\n"
    expect(file2).to.equal "var y;\n\ny = 2;\n"

  it "should pass scenario5 (wrap = 'Function')", ->
    expected = grunt.file.read('test/expected/scenario5.js')
    actual = grunt.file.read('tmp/scenario5.js')
    expect(actual).to.equal(expected)

