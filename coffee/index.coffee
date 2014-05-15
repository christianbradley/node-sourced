throws = -> throw new Error('No callback defined')

class Sourced
  constructor: (config = {}) ->
    @storage = config.storage
    @generateUUId = config.generateUUId if config.generateUUId?
    @setDefaults()

  setDefaults: ->
    @storage = new Sourced.MemoryStorage() unless @storage?

  generateUUId: ->
    require('uuid').v4()

  createRevision: (type, uuid, version = 0) ->
    uuid = @generateUUId() unless uuid?
    new Sourced.Revision
      resourceType: type,
      resourceId: uuid,
      resourceVersion: version

  storeRevision: (revision, callback = throws) ->
    @storage.store revision, callback

Sourced.Revision = require './Revision'
Sourced.MemoryStorage = require './MemoryStorage'
Sourced.RevisionConflict = require './RevisionConflict'
Sourced.RevisionOutOfSequence = require './RevisionOutOfSequence'

module.exports = Sourced
