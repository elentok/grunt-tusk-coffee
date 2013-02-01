# grunt-commoncoffee
# https://github.com/elentok/grunt-commoncoffee
# Copyright (c) 2013 David Elentok
# Licensed under the MIT license.

'use strict'

path = require 'path'
compile = require '../lib/compile'
helpers = require '../lib/helpers'

module.exports = (grunt) ->


  grunt.registerMultiTask 'commoncoffee', 'Compiles and combines coffeescript files', ->
    # Merge task-specific and/or target-specific options with these defaults.
    options = @options({
      separator: grunt.util.linefeed + grunt.util.linefeed,
      root: '.',
      runtime: true
      wrap: true
    })

    options.root = path.resolve(options.root)

    # Iterate over all specified file groups.
    this.files.forEach (fileObj) ->
      # The source files to be concatenated. The "nonull" option is used
      # to retain invalid files/patterns so they can be warned about.
      files = grunt.file.expand({nonull: true}, fileObj.src)

      # Concat specified files.
      src = files.map (filepath) ->
        # Warn if a source file/pattern was invalid.
        unless grunt.file.exists(filepath)
          grunt.log.error('Source file "' + filepath + '" not found.')
          return ''

        # Read file source.
        fullpath = path.resolve(filepath)
        moduleName = helpers.getModuleName(fullpath, options.root)
        source = compile(filepath)
        source = helpers.wrap(moduleName, source) if options.wrap
        source
      .join(options.separator)

      if options.runtime
        runtime = compile('lib/require_runtime.coffee', bare: false)
        src = runtime + grunt.util.linefeed + src
      src += grunt.util.linefeed

      # Write the destination file.
      grunt.file.write(fileObj.dest, src)

      # Print a success message.
      grunt.log.writeln("File \"#{fileObj.dest}\" created.")
