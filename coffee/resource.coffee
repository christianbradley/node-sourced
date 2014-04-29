Revision = require "./revision"

module.exports = class Resource

  constructor: (props) ->
    @setProperties props
    @setDefaults()

  setProperties: (props = {}) ->
    @type = props.type
    @uuid = props.uuid
    @version = props.version
    return this

  setDefaults: ->
    @type = @constructor.name unless @type?
    @uuid = @generateUUId() unless @uuid?
    @version = 0 unless @version?
    return this

  generateUUId: ->
    require("uuid").v4()

  revise: () ->
    new Revision
      resourceType: @type,
      resourceUUId: @uuid,
      number: @version + 1
