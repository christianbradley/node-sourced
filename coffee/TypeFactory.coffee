UnknownType = require './UnknownType'

# ## TypeFactory
module.exports = class TypeFactory

  # ### constructor
  # Create a new `TypeFactory` with properties `props`
  constructor: (props={}) ->
    @types = props.types
    @setDefaults()

  # ## setDefaults
  setDefaults: ->
    @types = {} unless @types?

  # ### register
  # Register types defined by mapping `map`
  register: (map = {}) ->
    @types[name] = constructor for own name, constructor of map

  # ### isRegistered
  isRegistered: (name) -> @type(name)?

  # ### type
  type: (name) -> @types[name]

  # ### construct
  # Construct an object of type `name` with the given `args`
  construct: (name, args...) ->
    throw new UnknownType(name) unless constructor = @type name
    object = Object.create constructor.prototype
    constructor.apply object, args
    return object
