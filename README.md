Table of Contents
================================================================================

* [Installation](#installation)
* [Usage](#usage)
  * [Construct a resource](#construct-a-resource)
  * [Revise a resource](#revise-a-resource)

Installation
================================================================================

Sourced is designed for use with [node.js][nodejs], and can be installed using __npm__:

```
npm install node-sourced
```

Usage
================================================================================

Examples in this document use assertions to illustrate the behavior and expectations of the underlying functionality.

    assert = require "assert"
    Sourced = require "sourced"


Construct a resource
--------------------------------------------------------------------------------
Resources represent an aggregate root within your domain. To construct a Resource, pass in the property values to the constructor:

    resource = new Sourced.Resource
      type: 'User',
      uuid: '0a16934f-be33-483a-a90f-90336d730d1d',
      version: 0

    assert.equal resource.type, 'User'
    assert.equal resource.uuid, '0a16934f-be33-483a-a90f-90336d730d1d'
    assert.equal resource.version, 0


Revise a resource
--------------------------------------------------------------------------------
Revisions represent an atomic set of changes within a resource's lifecycle. To create a revision, call the resource's `revise` method:

    rev1 = resource.revise()

    assert.equal rev1.resourceType, resource.type
    assert.equal rev1.resourceUUId, resource.uuid
    assert.equal rev1.number, 1

### Revision Identity
Revisions are uniquely identified by a key composed of the resource's `uuid` and the revision's `number`. You can retrieve an identity by calling the revision's `identify` method, returning an instance of `Revision.Identity`:

    id = rev1.identify()

    assert.equal id.resourceUUId, resource.uuid
    assert.equal id.number, rev1.number

RevisionIds can be viewed as a string containing the resource uuid followed by a hyphen and then a 32-bit hex representation of the revision number:

    strId = id.toString()
    assert.equal strId, '0a16934f-be33-483a-a90f-90336d730d1d-01000000'

Alternately, you can parse revision ids as follows:

    parsed = Sourced.Revision.Identity.parse strId
    assert.equal parsed.resourceUUId, resource.uuid
    assert.equal parsed.number, rev1.number


Adding events to a revision
--------------------------------------------------------------------------------
Revisions are useless without events. You can add events to a revision as follows:

    evt = rev1.addEvent 'Registered', username: 'john.doe'

    assert.equal evt.type, 'Registered'
    assert.equal evt.payload.username, 'john.doe'

    assert.equal evt.resourceType, resource.type
    assert.equal evt.resourceUUId, resource.uuid
    assert.equal evt.revisionNumber, rev1.number

    assert.equal evt.index, 0
    assert.equal rev1.events[0], evt

### Event Identity
Events are uniquely identified by a key composed of the resource's `uuid`, the revision's `number`, and the index of this event relative to its revision.

    id = evt.identify()

    assert.equal id.resourceUUId, resource.uuid
    assert.equal id.revisionNumber, rev1.number
    assert.equal id.index, evt.index

The string version of an EventId is similar to a RevisionId, but followed by another hyphen and an 8-bit hex representation of the event's index:

    strId = id.toString()
    assert.equal strId, '0a16934f-be33-483a-a90f-90336d730d1d-01000000-00'

[nodejs]: "http://www.nodejs.org"
