SourcedError = require './SourcedError'

module.exports = class NotImplemented extends SourcedError
  setDefaults: ->
    @message = "Not implemented" unless @message?
