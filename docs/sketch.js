// Generated by CoffeeScript 1.6.3
(function() {
  var Sourced, assert, event, payload, revision, sinon, sourced, stub;

  Sourced = require('sourced');

  assert = require('assert');

  sinon = require('sinon');

  sourced = new Sourced();

  assert(sourced.storage instanceof Sourced.MemoryStorage);

  revision = sourced.createRevision('User', 'fcc6b227-3e52-40af-a1a3-b276ecf97daa', 5);

  assert.equal('User', revision.resourceType);

  assert.equal('fcc6b227-3e52-40af-a1a3-b276ecf97daa', revision.resourceId);

  assert.equal(5, revision.resourceVersion);

  stub = sinon.stub(sourced, 'generateUUId');

  stub.returns('83ff08d6-d23c-4431-8613-dd5aa3da5e4b');

  revision = sourced.createRevision('User');

  assert.equal('83ff08d6-d23c-4431-8613-dd5aa3da5e4b', revision.resourceId);

  assert.equal(0, revision.resourceVersion);

  stub.restore();

  revision.addEvent('Registered', {
    username: 'john.doe',
    email: 'john.doe@example.com'
  });

  assert.equal(1, revision.events.length);

  event = revision.events[0];

  assert.equal('User', event.resourceType);

  assert.equal('83ff08d6-d23c-4431-8613-dd5aa3da5e4b', event.resourceId);

  assert.equal(0, event.resourceVersion);

  assert.equal('Registered', event.type);

  assert.equal(0, event.index);

  payload = event.payload;

  assert.equal('john.doe', payload.username);

  assert.equal('john.doe@example.com', payload.email);

  sourced.storeRevision(revision, function(error) {
    if (error) {
      throw error;
    }
    sourced.storeRevision(revision, function(error) {
      return assert(error instanceof Sourced.RevisionConflict);
    });
    revision.resourceVersion = 2;
    return sourced.storeRevision(revision, function(error) {
      return assert(error instanceof Sourced.RevisionOutOfSequence);
    });
  });

}).call(this);

/*
//@ sourceMappingURL=sketch.map
*/
