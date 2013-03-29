unless window.require?
  initializeModule = (module) ->
    try
      module.state = 'initializing'
      module.initializer(r, module)
      module.state = 'initialized'
    catch error
      throw new r.ModuleInitializerException(module.name, error)

  r = window.require = (moduleName) ->
    module = r.cache[moduleName]
    if module?
      if module.state is 'initializing'
        throw new r.ModuleInitializerException(module.name,
          "Circular reference")
      else if module.state is 'registered'
        initializeModule(module)
      module.exports
    else
      throw new r.MissingModuleException(moduleName)

  r.cache = {}

  r.register = (moduleName, initializer) ->
    r.cache[moduleName] = {
      name: moduleName,
      initializer: initializer,
      state: 'registered',
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

