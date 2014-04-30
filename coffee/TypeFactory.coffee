UnknownType = require './UnknownType'

module.exports = class TypeFactory

  constructor: (props = {}) ->
    @types = props.types
    @setDefaults()

  setDefaults: ->
    @types = {} unless @types?

  register: (map = {}) ->
    @types[name] = constructor for own name, constructor of map

  isRegistered: (name) -> @type(name)?

  type: (name) -> @types[name]

  construct: (name, args...) ->
    throw new UnknownType(name) unless constructor = @type name
    object = Object.create constructor.prototype
    constructor.apply object, args
    return object
