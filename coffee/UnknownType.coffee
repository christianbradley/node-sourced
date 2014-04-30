module.exports = class UnknownType extends Error

  constructor: (typeName) ->
    Error.captureStackTrace this, @constructor

    @name = @constructor.name
    @typeName = typeName

    Object.defineProperty this, 'message',
      enumerable: true, @getMessage

  getMessage: -> "Unknown type: #{@typeName}"
