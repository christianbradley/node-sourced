# Sourced

## Configuration

### Select a storage engine

Choose a [storage engines][storage-engines] for Sourced and initialize:

    storage = require("sourced-storage-mongo") "localhost/sourced"

### Create the service

Now you can create an instance of a Sourced [Service][class-service]

    service = require("sourced").service storage

### Define a schema

Next we need to define a [Schema][class-schema]:

    userSchema = {}

#### Construction

The schema allows for custom construction of your resource:

    userSchema.construct = (resource, done) ->
      new User id: resource.id

#### Events

It also allows you to customize the events for a given resource, and how they
are applied to the object. Let's define what our user looks like when applying
a "Registered" event:

    userSchema.onRegistered = (user, event, done) ->
      payload = event.payload
      user.username = payload.username
      user.email = payload.email
      done user

Next, let's define what it looks like when applying a "ProfileUpdated" event:

    userSchema.onProfileUpdated = (user, event, done) ->
      payload = event.payload
      user.profile.name = payload.name
      user.profile.title = payload.title
      done user


## Revising a resource

First we need to create a `uuid` to assign to the resource:

    uuid = require("uuid").v4()

Now we can start an initial revision for the resource:

    resource = sourced.resource("User", uuid)

Let's add two events to the revision. First, the user registered for an account:

    revision.add "Registered",
      username: "john.doe", email: "john.doe@example.com"

Then, they updated their profile:

    revision.add "ProfileUpdated",
      name: "John Doe", title: "Software Developer"

Now we have a revision
