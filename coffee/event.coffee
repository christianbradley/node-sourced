module.exports = class Event

  constructor: (props) ->
    @setProperties props
    @setDefaults()

  setProperties: (props = {}) ->
    @type = props.type
    @resourceType = props.resourceType
    @resourceUUId = props.resourceUUId
    @revisionNumber = props.revisionNumber
    @index = props.index
    @payload = props.payload

  setDefaults: ->
    @type = @constructor.name if @type is undefined
    @payload = {} if @payload is undefined

  identify: ->
    new Event.Identity
      resourceUUId: @resourceUUId,
      revisionNumber: @revisionNumber,
      index: @index

class Event.Identity

  constructor: (props) ->
    @setProperties props

  setProperties: (props = {}) ->
    @resourceUUId = props.resourceUUId
    @revisionNumber = props.revisionNumber
    @index = props.index

  toString: ->
    buf1 = new Buffer 4
    buf1.writeUInt32LE @revisionNumber, 0
    buf2 = new Buffer 1
    buf2.writeUInt8 @index, 0
    [@resourceUUId, buf1.toString('hex'), buf2.toString('hex')].join '-'
