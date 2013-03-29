path = require 'path'

module.exports =
  wrapCommonJS: (moduleName, source) ->
    "window.require.register('#{moduleName}', function(require, module) {\n" +
      source + "\n});"

  wrapInFunction: (source) ->
    "(function() {\n" +
      source + "\n})();"

  getModuleName: (fullpath, root) ->
    root = "#{root}/" unless /\/$/.test(root)
    ext = new RegExp(path.extname(fullpath) + '$')
    fullpath.replace(root, '').replace(ext, '')

