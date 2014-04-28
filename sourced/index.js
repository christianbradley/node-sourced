var Sourced = exports;

Sourced.Resource = Resource;

function Resource(params) {
  if(params == null) params = {};
  this.type = params.type;
  this.uuid = params.uuid;
  this.setDefaults();
};

Resource.prototype.setDefaults = function() {
  if(this.uuid === undefined)
    this.uuid = this.generateUUId();
  if(this.type === undefined)
    this.type = this.constructor.name;
};

Resource.prototype.generateUUId = function() {
  return require("uuid").v4();
};
