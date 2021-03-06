// Generated by CoffeeScript 1.6.3
(function() {
  var Resource, Schema;

  Resource = require('./Resource');

  module.exports = Schema = (function() {
    function Schema(props) {
      if (props == null) {
        props = {};
      }
      this.resourceType = props.resourceType;
      this.handlers = props.handlers;
      this.setDefaults();
    }

    Schema.prototype.setDefaults = function() {
      return this.handlers = {};
    };

    Schema.prototype.constructResource = function(resourceId) {
      return new Resource({
        id: resourceId
      });
    };

    Schema.prototype.setResourceVersion = function(resource, version) {
      resource.version = version;
      return resource;
    };

    Schema.prototype.defineEventHandler = function(type, handler) {
      return this.handlers[type] = handler;
    };

    Schema.prototype.isEventHandlerDefined = function(type) {
      return this.handlers.hasOwnProperty(type);
    };

    Schema.prototype.applyEvent = function(resource, event) {
      return this.handlers[event.type].call(null, resource, event);
    };

    return Schema;

  })();

}).call(this);

/*
//@ sourceMappingURL=Schema.map
*/
