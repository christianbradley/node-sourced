Event = require "./event"
RevisionId = require "./revision-id"

module.exports = class Revision

  constructor: (props) ->
    @setProperties props
    @setDefaults()
    Object.defineProperty this, "id", enumerable: true, get: @identify

  setProperties: (props = {}) ->
    @resourceType = props.resourceType
    @resourceUUId = props.resourceUUId
    @number = props.number

  setDefaults: () ->
    @events = []

  identify: ->
    new Revision.Identity resourceUUId: @resourceUUId, number: @number

  addEvent: (type, payload) ->
    event = new Event
      type: type,
      payload: payload,
      resourceType: @resourceType,
      resourceUUId: @resourceUUId,
      revisionNumber: @number,
      index: @events.length

    @events.push event
    return event

class Revision.Identity

  constructor: (props) ->
    @setProperties props

  setProperties: (props = {}) ->
    @resourceUUId = props.resourceUUId
    @number = props.number

  toString: ->
    buffer = new Buffer 4
    buffer.writeUInt32LE @number, 0
    @resourceUUId + "-" + buffer.toString "hex"

Revision.Identity.parse = (str = "") ->
  str = str.replace /-/g, ''
  buffer = new Buffer str, 'hex'
  uuid = require('uuid').unparse buffer.slice(0,16)
  number = buffer.readUInt32LE 16

  new Revision.Identity resourceUUId: uuid, number: number
