module.exports = class SourcedError extends Error

  constructor: (props = {}) ->
    Error.call this
    Error.captureStackTrace this, @constructor
    @name = props.name
    @message = props.message
    @setDefaults()

  setDefaults: ->
    @name = @constructor.name unless @name?
