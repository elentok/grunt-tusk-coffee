# grunt-tusk-coffee
# https://github.com/elentok/grunt-tusk-coffee
# Copyright (c) 2013 David Elentok
# Licensed under the MIT license.

'use strict'

fs = require 'fs'
path = require 'path'
compile = require '../lib/compile'
helpers = require '../lib/helpers'

module.exports = (grunt) ->
  description = 'Compiles and combines coffeescript files'
  grunt.registerMultiTask 'tusk_coffee', description, ->
    compiler = new TuskCoffeeCompiler(grunt, @files, @options)
    compiler.compile()

class TuskCoffeeCompiler
  constructor: (@grunt, @fileGroups, @options) ->
    @_addDefaultOptions()

  _addDefaultOptions: ->
    @options = @options({
      separator: @grunt.util.linefeed + @grunt.util.linefeed,
      modulesRoot: '.',
      runtime: false
      wrap: 'CommonJS'
    })
    @options.modulesRoot = path.resolve(@options.modulesRoot)

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
    fs.mkdirSync(dest) unless @grunt.file.isDir(dest)
    files.forEach (filepath) =>
      source = @_compileFile(filepath)
      sourceFilename = path.basename(filepath)
      outputFilename = sourceFilename.replace('.coffee', '.js')
      outputFilepath = path.join(dest, outputFilename)
      @grunt.file.write(outputFilepath, source)
      @grunt.log.writeln("File #{outputFilepath} created.")


  _compileAndJoin: (files, dest) ->
    source = files.map (filepath) => @_compileFile(filepath)
    source = source.join(@options.separator)

    if @options.runtime and @options.wrap == 'CommonJS'
      source = @_getRequireRuntime() + source
    source += @grunt.util.linefeed

    @grunt.file.write(dest, source)
    @grunt.log.writeln("File \"#{dest}\" created.")

  _compileFile: (filepath) ->
    return '' unless @_fileExists(filepath)

    source = compile(filepath)
    @_wrap(filepath, source)

  _wrap: (filepath, source) ->
    if @options.wrap == 'CommonJS'
      fullpath = path.resolve(filepath)
      moduleName = helpers.getModuleName(fullpath, @options.modulesRoot)
      helpers.wrapCommonJS(moduleName, source)
    else if @options.wrap == 'Function'
      helpers.wrapInFunction(source)
    else
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

