# 
# grunt-commoncoffee
# https://github.com/elentok/grunt-commoncoffee
# 
# Copyright (c) 2013 David Elentok
# Licensed under the MIT license.
# 

'use strict'

module.exports = (grunt) ->

  # Please see the grunt documentation for more information regarding task
  # creation: https://github.com/gruntjs/grunt/blob/devel/docs/toc.md

  grunt.registerMultiTask 'commoncoffee', 'Your task description goes here.', ->
    # Merge task-specific and/or target-specific options with these defaults.
    options = @options({
      punctuation: '.',
      separator: ', '
    })

    # Iterate over all specified file groups.
    this.files.forEach (fileObj) ->
      # The source files to be concatenated. The "nonull" option is used
      # to retain invalid files/patterns so they can be warned about.
      files = grunt.file.expand({nonull: true}, fileObj.src);

      # Concat specified files.
      src = files.map (filepath) ->
        # Warn if a source file/pattern was invalid.
        unless grunt.file.exists(filepath)
          grunt.log.error('Source file "' + filepath + '" not found.')
          return ''

        # Read file source.
        return grunt.file.read(filepath)
      .join(options.separator)

      # Handle options.
      src += options.punctuation

      # Write the destination file.
      grunt.file.write(fileObj.dest, src)

      # Print a success message.
      grunt.log.writeln("File \"#{fileObj.dest}\" created.")
