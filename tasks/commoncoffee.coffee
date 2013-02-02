# grunt-commoncoffee
# https://github.com/elentok/grunt-commoncoffee
# Copyright (c) 2013 David Elentok
# Licensed under the MIT license.

'use strict'

path = require 'path'
compile = require '../lib/compile'
helpers = require '../lib/helpers'

module.exports = (grunt) ->
  description = 'Compiles and combines coffeescript files'
  grunt.registerMultiTask 'commoncoffee', description, ->
    compiler = new CommonCompiler(grunt, @files, @options)
    compiler.compile()

class CommonCompiler
  constructor: (@grunt, @fileGroups, @options) ->
    console.log "CommonCompiler"
    @_addDefaultOptions()

  _addDefaultOptions: ->
    @options = @options({
      separator: @grunt.util.linefeed + @grunt.util.linefeed,
      root: '.',
      runtime: true
      wrap: true
    })
    @options.root = path.resolve(@options.root)

  compile: ->
    @fileGroups.forEach (fileGroup) =>
      @_compileFileGroup(fileGroup)

  _compileFileGroup: (fileGroup) ->
    files = @_getSourceFiles(fileGroup)
    if /\/$/.test(fileGroup.dest)
      @_compileSeparately(files, fileGroup.dest)
    else
      @_compileAndJoin(files, fileGroup.dest)

  _getSourceFiles: (fileGroup) ->
    # The source files to be concatenated. The "nonull" option is used
    # to retain invalid files/patterns so they can be warned about.
    @grunt.file.expand({nonull: true}, fileGroup.src)

  _compileSeparately: (files, dest) ->
    filenames = []
    files.forEach (filepath) =>
      source = @_compileFile(filepath)
      sourceFilename = path.basename(filepath)
      outputFilename = sourceFilename.replace('.coffee', '.js')
      outputFilepath = path.join(dest, outputFilename)
      @grunt.file.write(outputFilepath, source)
      filenames.push(sourceFilename)
    @grunt.log.writeln("Files #{filenames.join(', ')} created.")


  _compileAndJoin: (files, dest) ->
    source = files.map (filepath) => @_compileFile(filepath)
    source = source.join(@options.separator)

    source = @_getRequireRuntime() + source if @options.runtime
    source += @grunt.util.linefeed

    @grunt.file.write(dest, source)
    @grunt.log.writeln("File \"#{dest}\" created.")

  _compileFile: (filepath) ->
    return '' unless @_fileExists(filepath)

    fullpath = path.resolve(filepath)
    moduleName = helpers.getModuleName(fullpath, @options.root)
    source = compile(filepath)
    source = helpers.wrap(moduleName, source) if @options.wrap
    source

  _getRequireRuntime: (source) ->
    require_runtime_path =
      path.resolve(__dirname, '../lib/require_runtime.coffee')
    compile(require_runtime_path, bare: false) + @grunt.util.linefeed

  _fileExists: (filepath) ->
    if @grunt.file.exists(filepath)
      true
    else
      @grunt.log.error('Source file "' + filepath + '" not found.')
      false

