unless window.require?
  initializeModule = (module) ->
    try
      module.initializer(r, module)
      module.initialized = true
    catch error
      throw new r.ModuleInitializerException(module.name, error)

  r = window.require = (moduleName) ->
    module = r.cache[moduleName]
    if module?
      initializeModule(module) unless module.initialized
      module.exports
    else
      throw new r.MissingModuleException(moduleName)

  r.cache = {}

  r.register = (moduleName, initializer) ->
    r.cache[moduleName] = {
      name: moduleName,
      initializer: initializer,
      initialized: false,
      exports: null
    }

  
  class r.MissingModuleException
    constructor: (@moduleName) ->
      @message = "Cannot find module '#{@moduleName}'"
      console?.error(@message)

  # make it a real javascript error
  r.MissingModuleException.prototype = new Error()
  r.MissingModuleException.prototype.constructor = r.MissingModuleException

  class r.ModuleInitializerException
    constructor: (@moduleName, @innerException) ->
      @message = "Error initializing module '#{@moduleName}': " +
        @innerException
      console?.error(@message)

  # make it a real javascript error
  r.ModuleInitializerException.prototype = new Error()
  r.ModuleInitializerException.prototype.constructor =
    r.ModuleInitializerException

