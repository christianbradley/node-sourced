module.exports = class RevisionOutOfSequence
  constructor: () ->
    Error.call this
    Error.captureStackTrace this, @constructor
    @name = @constructor.name
    
