## Resource
Represents an aggregate root within a given domain.

    Sourced = require 'sourced'
    Sinon = require 'sinon'
    assert = require 'assert'

### Defining resource classes

The base resource class is meant to be an abstraction for you to extend. Define your own resource class as follows:

    class AuthorizationDomainResource extends Sourced.Resource
      getDomainName: -> 'MyApp'

    class UserResource extends AuthorizationDomainResource
      getType: -> 'User'

As shown above, it is suggested to first define a base class for your domain resources that overrides `getDomainName`, and then define resource classes, extending the base class and overridding `getType`.

You __must__ override the `getDomainName` and `getType` prototype methods. These methods are used to return the read-only values from `domainName` and `type`:

    user = new UserResource

    assert.equal user.domainName, 'MyApp'
    assert.equal user.type, 'User'


### Resource identity

A resource must be universally unique, utilizing some form of [uuid] as its identity. By default, a [version 4 uuid] is generated for all resources upon initialization. You can customize this functionality by overriding the `generateUUId` method on your resource prototype:

    generateUUId = Sinon.stub UserResource.prototype, 'generateUUId'
    generateUUId.returns 'b2411aae-6edf-4c49-b177-9a9ddca90f67'

    user = new UserResource

    assert.equal user.uuid, 'b2411aae-6edf-4c49-b177-9a9ddca90f67'
    generateUUId.restore()




[uuid]: http://en.wikipedia.org/wiki/Uuid
[version 4 uuid]: http://en.wikipedia.org/wiki/Uuid#Version_4_.28random.29
