ChildProcess = require 'child_process'

COFFEE_PATH = "./coffee"
TESTS_PATH = "./docs"
BUILD_PATH = "./package"

spawn = (command, args, options, callback) ->
  proc = ChildProcess.spawn command, args, options

  proc.stdout.pipe process.stdout
  proc.stderr.pipe process.stderr

  proc.on 'error', (error) ->
    console.error 'An error occurred', error
    callback error

  proc.on 'exit', (code, signal) ->
    callback null, code, signal

compile = (callback) ->
  args = ['-cmo', BUILD_PATH, COFFEE_PATH]
  spawn 'coffee', args, null, callback

test = (callback) ->
  args = ['-l', TESTS_PATH]
  spawn 'coffee', args, null, callback

watch = (callback) ->
  args = ['-cwmo', BUILD_PATH, COFFEE_PATH]
  spawn 'coffee', args, null, callback

noop = -> undefined

task 'compile', 'Compile coffee files', -> compile noop
task 'watch', 'Watch coffee files and compile', -> watch noop
task 'test', 'Execute tests', -> test noop
