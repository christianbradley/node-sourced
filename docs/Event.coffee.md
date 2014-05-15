## Event

Events represent an occurrence within the lifecycle of a [Resource].

    Sourced = require 'sourced'
    assert = require 'assert'

### Defining an event

The base event class is meant to be an abstraction for you to extend. Define your own event class as follows:

    class UserEvent extends Sourced.Event
      getDomainName: -> 'MyApp',
      getResourceType: -> 'User'

    class UserRegistered extends UserEvent
      getType: -> 'Registered'

As shown above, it is suggested to first define a base class for your events that overrides `getDomainName` and `getResourceType`, and then define event classes, extending the base class and overriding `getType` and `setPayload`.

You __must__ override the `getDomainName`, `getResourceType`, and `getType` methods. These methods are used to return the read-only values from their respective properties:

    registered = new UserRegistered

    assert.equal registered.type, 'Registered'
    assert.equal registered.domainName, 'MyApp'
    assert.equal registered.resourceType, 'User'

You __should__ override the `setPayload` method. By default, the payload is set to the object value passed as the first parameter:

    registered.setPayload foo: 'foo'
    assert.equal registered.payload.foo, 'foo'

Overriding the default prototype method encourages exclusivity of this property, and provides an opportunity to customize default values or perform translation:

    class Registration
      constructor: (props = {}) ->
        @username = props.username
        @email = props.email


    UserRegistered::setPayload = (params = {}) ->
      @payload = new Registration params

    registered = new UserRegistered payload:
      foo: 'foo', username: 'john.doe', email: 'john.doe@example.com'

    payload = registered.payload

    assert.equal payload.foo, undefined
    assert.equal payload.username, 'john.doe'
    assert.equal payload.email, 'john.doe@example.com'
