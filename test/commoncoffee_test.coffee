'use strict'

grunt = require('grunt')
expect = (require 'chai').expect

describe "bla", ->
  it "should be bla", ->
    expect(1).to.equal(2)

#
# ======== A Handy Little Nodeunit Reference ========
# https://github.com/caolan/nodeunit
#
# Test methods:
#   test.expect(numAssertions)
#   test.done()
# Test assertions:
#   test.ok(value, [message])
#   test.equal(actual, expected, [message])
#   test.notEqual(actual, expected, [message])
#   test.deepEqual(actual, expected, [message])
#   test.notDeepEqual(actual, expected, [message])
#   test.strictEqual(actual, expected, [message])
#   test.notStrictEqual(actual, expected, [message])
#   test.throws(block, [error], [message])
#   test.doesNotThrow(block, [error], [message])
#   test.ifError(value)
#

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
