grunt-tusk-coffee
==================

> Compiles and concatenates coffee script files

> Can wrap each file in a CommonJS module or function

Getting Started
------------------
_If you haven't used [grunt][] before, be sure to check out the [Getting Started][] guide._

From the same directory as your project's [Gruntfile][Getting Started] and [package.json][], install this plugin with the following command:

```bash
npm install grunt-tusk-coffee --save-dev
```

Once that's done, add this line to your project's Gruntfile:

```js
grunt.loadNpmTasks('grunt-tusk-coffee');
```

If the plugin has been installed correctly, running `grunt --help` at the command line should list the newly-installed plugin's task or tasks. In addition, the plugin should be listed in package.json as a `devDependency`, which ensures that it will be installed whenever the `npm install` command is run.

[grunt]: http://gruntjs.com/
[Getting Started]: https://github.com/gruntjs/grunt/blob/devel/docs/getting_started.md
[package.json]: https://npmjs.org/doc/json.html

The "tusk_coffee" task
----------------------

### Overview
In your project's Gruntfile, add a section named `tusk_coffee` to the data object passed into `grunt.initConfig()`.

```coffeescript
grunt.initConfig
  tusk_coffee:
    your_target:
      options:
        # Task-specific options go here.
      files:
        # Target-specific file lists and/or options go here.
```

### Options

#### options.wrap
Type: `String`
Default value: `"CommonJS"`

* When `"CommonJS"`, wraps each file in a `"window.require.register(...)"` block.
* When `"Function"`, wraps each file in a `"(function () { ... })()"` block.
* When null or false it doesn't wrap.

#### options.modulesRoot
Type: `String`
Default value: `'.'`

The root of the module files.

For example, by default, to load the file "src/files/file1.coffee" in the 
browser you will run "`require 'src/files/file1'`".

If you set `modulesRoot` to `src/files` you can use "`require 'file1'`"

#### options.runtime
Type: `Boolean`
Default value: `false`

When true, add the require() method code at the beginning of each generated file.

### Usage Examples

This is the way I use this plugin, the following configuration will generate two files:

* public/app.js - includes the require() method code and all of the compiled coffeescript files wrapped in modules.
* public/vendor.js - the combined vendor javascripts (without the require method code and without wrapping).

```coffeescript
grunt.initConfig
  tusk_coffee:
    app:
      options:
        modulesRoot: 'src'
      files:
        'public/app.js': ['src/**/*.coffee'],

    vendor:
      options:
        wrap: null
        runtime: false
      files:
        'public/vendor.js': [
          'vendor/zepto/zepto.js',
          'vendor/backbone/backbone.js'
          'vendor/bootstrap/javascripts/*.js'
        ]
```

## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality. Lint and test your code using [grunt][].

## Release History
_(Nothing yet)_
