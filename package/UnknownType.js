// Generated by CoffeeScript 1.6.3
var UnknownType,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

module.exports = UnknownType = (function(_super) {
  __extends(UnknownType, _super);

  function UnknownType(typeName) {
    Error.captureStackTrace(this, this.constructor);
    this.name = this.constructor.name;
    this.typeName = typeName;
    Object.defineProperty(this, 'message', {
      enumerable: true
    }, this.getMessage);
  }

  UnknownType.prototype.getMessage = function() {
    return "Unknown type: " + this.typeName;
  };

  return UnknownType;

})(Error);

/*
//@ sourceMappingURL=UnknownType.map
*/
