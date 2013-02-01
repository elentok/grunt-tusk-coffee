path = require 'path'
grunt = require 'grunt'
coffeescript = require 'coffee-script'

compilers =
  js: (source, filepath) ->
    source
  coffee: (source, filepath) ->
    coffeescript.compile(source, filename: filepath, bare: true)

module.exports = (filepath) ->
  source = grunt.file.read(filepath)
  extension = path.extname(filepath).substring(1)
  compiler = compilers[extension]

  try
    return compiler(source, filepath)
  catch error
    grunt.log.error(error)
    grunt.fail.warn('failed to compile')


