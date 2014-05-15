module.exports = class RevisionConflict extends Error
  constructor: () ->
    Error.call this
    Error.captureStackTrace this, @constructor
    @name = 'RevisionConflict'
