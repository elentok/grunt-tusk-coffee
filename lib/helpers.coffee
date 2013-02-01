path = require 'path'

module.exports =
  wrap: (moduleName, source) ->
    "window.require.register('#{moduleName}', function(require, module) {\n" +
      source + "\n});"

  getModuleName: (fullpath, root) ->
    root = "#{root}/" unless /\/$/.test(root)
    ext = new RegExp(path.extname(fullpath) + '$')
    fullpath.replace(root, '').replace(ext, '')

