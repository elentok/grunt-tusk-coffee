expect = (require 'chai').expect
compile = require '../lib/compile'

describe "lib/compile (function)", ->
  describe "with a .coffee file", ->
    it "compile it into javascript", ->
      output = compile('test/fixtures/file1.coffee')
      expect(output).to.equal "var x;\n\nx = 1;\n"

  describe "with a .js file", ->
    it "returns the js", ->
      output = compile('test/fixtures/file3.js')
      expect(output).to.equal "var z = 3;\n"






