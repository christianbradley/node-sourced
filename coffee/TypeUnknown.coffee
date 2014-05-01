SourcedError = require './SourcedError'

class TypeUnknown extends SourcedError

  constructor: (props = {}) ->
    @typeName = props.typeName
    super

  setDefaults: ->
    @message = "Unknown type: '#{@typeName}'"
    super

module.exports = TypeUnknown
