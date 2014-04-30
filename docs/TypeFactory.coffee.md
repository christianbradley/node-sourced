## Type Factory

Maintains a mapping between type names and constructors to allow for dynamic creation of objects.

    assert = require 'assert'
    Sourced = require 'sourced'
    factory = new Sourced.TypeFactory

### Registering Constructors
Let's say we want a factory with the following types:

    class User

      constructor: (props={}) ->
        @username = props.username

    class Person

      constructor: (first, last) ->
        @name = "#{first} #{last}"

      sayHello: ()-> "Hi, I'm #{@name}"


To register them with the factory, just pass them in as a hash with their names as the keys:

    factory.register User: User, Person: Person

The factory should now know about the registered types:

    assert factory.isRegistered 'User'
    assert factory.isRegistered 'Person'

    assert !factory.isRegistered 'Baz'

### Retrieving Constructors
Once registered, constructors can be retrieved using:

    assert.equal factory.type('User'), User
    assert.equal factory.type('Person'), Person

### Constructing Instances
Generally, you will use a type factory to construct instances dynamically:

    user = factory.construct 'User', username: 'john.doe'

    assert.equal user.constructor, User
    assert.equal user.username, 'john.doe'

The constructor's arity does not matter, arguments are passed on in the order they are received:

    john = factory.construct 'Person', 'John', 'Doe'

    assert john instanceof Person
    assert.equal john.name, 'John Doe'

Prototype methods also work as expected:

    assert.equal john.sayHello(), "Hi, I'm John Doe"

### Unknown Types

If an unknown type is requested, the factory throws an [UnknownType] error:

    try
      factory.construct 'Baz', name: 'baz'
      assert.fail 'Should not get here'

    catch error
      assert error instanceof Sourced.UnknownType
      assert.equal error.name, 'UnknownType'
      assert.equal error.message, 'Unknown type: Baz'
      assert.equal error.typeName, 'Baz'

[UnknownType]: ./UnknownType.coffee.md
