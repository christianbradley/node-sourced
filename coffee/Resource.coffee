NotImplemented = require './NotImplemented'

module.exports = class Resource

  constructor: (props = {}) ->
    @uuid = props.uuid

    Object.defineProperty this, 'domainName',
      enumerable: true, get: @getDomainName

    Object.defineProperty this, 'type',
      enumerable: true, get: @getType

    @setDefaults()

  setDefaults: ->
    @uuid = @generateUUId() unless @uuid?

  generateUUId: ->
    require('uuid').v4()

  getDomainName: ->
    throw new NotImplemented

  getType: ->
    throw new NotImplemented
