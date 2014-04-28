Table of Contents
================================================================================

* [Installation]
* [Usage]
* [API]




Installation
================================================================================

Sourced is designed for use with [node.js][nodejs], and can be installed using __npm__:

```
npm install node-sourced
```




Usage
================================================================================

* [Example dependencies]
* [Construct a resource]


Example dependencies
--------------------------------------------------------------------------------
Examples in this document use assertions to illustrate the behavior and expectations of the underlying functionality.

    assert = require "assert"

The Sourced module contains references to all of the c

    Sourced = require "sourced"


Construct a resource
--------------------------------------------------------------------------------
Resources represent an aggregate root within your domain. They are composed of a `type` and a `uuid`. To construct a Resource, pass in the property values to the constructor:

    resource = new Sourced.Resource
      type: 'User',
      uuid: '0a16934f-be33-483a-a90f-90336d730d1d'

    assert.equal resource.type, 'User'
    assert.equal resource.uuid, '0a16934f-be33-483a-a90f-90336d730d1d'

If you do not assign a `uuid`, one will be generated for you using the method defined on the Resource prototype. You can customize this method by extending the Resource class:

    class CustomResource extends Sourced.Resource
      generateUUId: ->
        '0a16934f-be33-483a-a90f-90336d730d1d'

    resource = new CustomResource type: 'User'

    assert.equal resource.type, 'User'
    assert.equal resource.uuid, '0a16934f-be33-483a-a90f-90336d730d1d'

If you like, you can extend the Resource class for each of your aggregates. By default, the `type` will be inferred from the constructor name:

    class User extends CustomResource

    user = new User

    assert.equal user.type, 'User'
    assert.equal user.uuid, '0a16934f-be33-483a-a90f-90336d730d1d'




[nodejs]: "http://www.nodejs.org"
