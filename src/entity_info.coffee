
_ = require "underscore"

###*
Reprents a single entity. Internally used to store mapping info and stuff.
###
class exports.EntityInfo
  jsonName : null
  
  constructor: (@jsonName, @originalSchema) ->
    @properties = []

  property: (name) ->
    _.select( @properties, (x) -> x.jsonName == name)[0]
    