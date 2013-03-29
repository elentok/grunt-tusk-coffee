expect = (require 'chai').expect
helpers = require '../lib/helpers'

describe "lib/helpers", ->
  describe "#wrapCommonJS", ->
    it "wraps a file in commonjs wrapper", ->
      actual = helpers.wrapCommonJS('the_module_name', 'bla')
      expected =
        "window.require.register('the_module_name', " +
          "function(require, module) {\n" +
        "bla\n" +
        "});"
      expect(actual).to.equal(expected)

  describe "#wrapInFunction", ->
    it "wraps a file in a function wrapper", ->
      actual = helpers.wrapInFunction('bla')
      expected =
        "(function() {\n" +
        "bla\n" +
        "})();"
      expect(actual).to.equal(expected)

  describe "#getModuleName", ->
    describe "when root is /abc", ->
      it "returns 'def' for /abc/def.coffee", ->
        name = helpers.getModuleName('/abc/def.coffee', '/abc')
        expect(name).to.equal 'def'
      it "returns 'def/ghi' for /abc/def/ghi.coffee", ->
        name = helpers.getModuleName('/abc/def/ghi.coffee', '/abc')
        expect(name).to.equal 'def/ghi'


