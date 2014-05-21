// Generated by CoffeeScript 1.6.3
(function() {
  var Sourced;

  Sourced = exports;

  Sourced.Service = require('./Service');

  Sourced.Revision = require('./Revision');

  Sourced.MemoryStorage = require('./MemoryStorage');

  Sourced.RevisionConflict = require('./RevisionConflict');

  Sourced.RevisionOutOfSequence = require('./RevisionOutOfSequence');

  Sourced.Resource = require('./Resource');

  Sourced.Schema = require('./Schema');

  Sourced.createService = function(config) {
    return new Sourced.Service(config);
  };

}).call(this);

/*
//@ sourceMappingURL=index.map
*/
