# Usage

For the examples in this document, we will require the `sourced` module and assign it to a variable for later use:

    Sourced = require 'sourced'

In addition, the `assert` library will be used to demonstrate the results of various methods:

    assert = require 'assert'

To demonstrate the coordination between objects, we will use mocks and stubs via the [sinon] package:

    sinon = require 'sinon'

## Create and configure the service object

The core sourced module exports a function that acts as a service object constructor. You can create an instance using the `new` operator, passing in an object representing the configured dependencies. If you do not provide a configuration, sane defaults will be used.

    sourced = new Sourced()

### Storage configuration

The service object needs to know how to persist data. The core library comes with a simple `MemoryStorage` adapter, which is used by default. For real applications, you will want to use one of the persisted [storage adapters] or write your own.

    assert sourced.storage instanceof Sourced.MemoryStorage


## Creating revisions

A revision represents an atomic collection of events that have occurred at a given point within a resource's lifecycle. To create a revision, pass in the resource `type`, `uuid`, and the `version` of that resource to the service's `createRevision` method:

    revision = sourced.createRevision 'User', 'fcc6b227-3e52-40af-a1a3-b276ecf97daa', 5

The revision object should know about its associated resource and its version:

    assert.equal 'User', revision.resourceType
    assert.equal 'fcc6b227-3e52-40af-a1a3-b276ecf97daa', revision.resourceId
    assert.equal 5, revision.resourceVersion

### Defaults

You may omit both the `uuid` and `version` parameters, and sane defaults will be applied.

By default, a uuid will be generated for the resource, and its version set to `0`, representing an initial revision.

You can override the default uuid generator by replacing the `generateUUId` method with your own. Let's stub the method so we can demonstrate that behavior:

    stub = sinon.stub sourced, 'generateUUId'
    stub.returns '83ff08d6-d23c-4431-8613-dd5aa3da5e4b'

You can see that a default uuid has been generated, and the version has been set to `0`:

    revision = sourced.createRevision 'User'
    assert.equal '83ff08d6-d23c-4431-8613-dd5aa3da5e4b', revision.resourceId
    assert.equal 0, revision.resourceVersion

We don't want to leave that stubbed generator method there, so let's restore the original:

    stub.restore()

## Adding events to a revision

A revision must contain one or more events to have any effect. Let's add a single event to our initial revision:

    revision.addEvent 'Registered',
      username: 'john.doe', email: 'john.doe@example.com'


The revision maintains a collection of the events that have been added:

    assert.equal 1, revision.events.length

You can access the events by their index, just like an array:

    event = revision.events[0]

Each event will hold a reference to the resource and version:

    assert.equal 'User', event.resourceType
    assert.equal '83ff08d6-d23c-4431-8613-dd5aa3da5e4b', event.resourceId
    assert.equal 0, event.resourceVersion

They also contain their type, and the order in which they were added...

    assert.equal 'Registered', event.type
    assert.equal 0, event.index

... as well as the payload that they were assigned upon creation is accessible via the `payload` property:

    payload = event.payload

    assert.equal 'john.doe', payload.username
    assert.equal 'john.doe@example.com', payload.email

## Storing revisions

Now that we have an initial revision for our User, it needs to be persisted to storage so that we can rebuild our resource at a later point. The service object exposes a method to do this:

    sourced.storeRevision revision, (error) ->
      throw error if error

### Revision conflicts

> If you attempt to store a revision of a resource with a version that has previously been stored, a revision conflict will be raised:

      sourced.storeRevision revision, (error) ->
        assert error instanceof Sourced.RevisionConflict

### Sequence errors

> If you attempt to store a revision with a version that is not in sequence (ie: it is not exactly 1 more than the previous version), a sequence error will be raised:

      revision.resourceVersion = 2
      sourced.storeRevision revision, (error) ->
        assert error instanceof Sourced.RevisionOutOfSequence

[storage adapters]: ./storage-adapters.coffee.md
[sinon]: http://sinonjs.org
