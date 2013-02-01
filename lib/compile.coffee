path = require 'path'
grunt = require 'grunt'
coffeescript = require 'coffee-script'

compilers =
  js: (source, filepath, options) ->
    source
  coffee: (source, filepath, options) ->
    options = grunt.util._.extend({ filename: filepath, bare: true }, options)
    coffeescript.compile(source, options)

module.exports = (filepath, options = {}) ->
  source = grunt.file.read(filepath)
  extension = path.extname(filepath).substring(1)
  compiler = compilers[extension]

  try
    return compiler(source, filepath, options)
  catch error
    grunt.log.error(error)
    grunt.fail.warn('failed to compile')


