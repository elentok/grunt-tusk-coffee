path = require 'path'
expect = (require 'chai').expect

require_runtime_file = path.resolve('lib/require_runtime.coffee')

describe "require-runtime", ->
  beforeEach ->
    delete require.cache[require_runtime_file]

  describe "when window.require isn't defined", ->
    it "defines window.require", ->
      global.window = {}
      require '../lib/require_runtime'
      expect(global.window.require).to.be.a 'function'
      delete global.window

  describe "when window.require is defined", ->
    it "defines window.require", ->
      global.window = require: 'bob'
      require '../lib/require_runtime'
      expect(global.window.require).to.equal 'bob'

  describe "#require", ->
    beforeEach ->
      global.window = {}
      require '../lib/require_runtime'
      @r = global.window.require

    describe "when the module was registered", ->
      describe "and initialized", ->
        it "returns the value of module.exports", ->
          i = 0
          @r.register 'my_module', (require, module) ->
            module.exports = ++i
          result1 = @r('my_module')
          result2 = @r('my_module')
          expect(result1).to.eql(result2)


      describe "and not initialized,", ->
        describe "when initializer throws an exception", ->
          it "throws a require.ModuleInitializerException", ->
            inner_ex = new Error('bla')
            @r.register 'my_module', (require, module) ->
              throw inner_ex

            fn = => @r('my_module')
            expect(fn).to.throw @r.ModuleInitializerException,
              "Error initializing module 'my_module': Error: bla"

        describe "when initializer run successfuly", ->
          it "returns the value of module.exports", ->
            @r.register 'my_module', (require, module) ->
              module.exports = 'the_module_exports'
            result = @r('my_module')
            expect(result).to.eql 'the_module_exports'

        describe "when initializer doesn't fill module.exports", ->
          it "returns null", ->
            @r.register 'my_module', (require, module) ->
            expect(@r('my_module')).to.be.null


        it "sends the arguments 'require' and 'module' to the initializer", ->
          @r.register 'my_module', (require, module) =>
            expect(require).to.eql @r
            expect(module.name).to.eql 'my_module'
          @r('my_module')

    describe "when the module wasn't registered", ->
      it "throws a require.MissingModuleException", ->
        exception = new @r.MissingModuleException('invalid-file')
        fn = => @r('invalid-file')
        expect(fn).to.throw @r.MissingModuleException,
          /Cannot find module 'invalid-file'/



