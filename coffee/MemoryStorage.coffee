RevisionConflict = require './RevisionConflict'
RevisionOutOfSequence = require './RevisionOutOfSequence'

throws = -> throw new Error('No callback defined')

module.exports = class MemoryStorage
  constructor: (props = {}) ->
    @collection = props.collection
    @setDefaults()

  setDefaults: ->
    @collection = [] unless @collection?

  store: (revision, callback = throws) ->
    revisionId = [
        revision.resourceType,
        revision.resourceId,
        revision.resourceVersion
      ].join(',')

    if @collection[revisionId]?
      error = new RevisionConflict()
      return callback(error)

    previousId = [
      revision.resourceType,
      revision.resourceId,
      revision.resourceVersion - 1
    ].join(',')

    unless revision.resourceVersion is 0 or @collection[previousId]?
      error = new RevisionOutOfSequence()
      return callback(error)

    @collection[revisionId] = revision
    callback()
