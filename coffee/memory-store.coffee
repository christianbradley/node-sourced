module.exports = class MemoryStore

  constructor: (props) ->
    @setProperties props
    @setDefaults()

  setProperties: (props = {}) ->
    @hash = props.hash

  setDefaults: ->
    @hash = {} unless @hash?

  store: (revision, cb) ->
    @hash[revision.id] = revision
    cb null, revision.id

  find: (id, cb) ->
    revision = @hash[id]
    cb null, revision
