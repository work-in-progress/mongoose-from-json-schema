
mongoose = require 'mongoose'
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
  
  # Returns the model name to use in mongoose
  mongooseModelName: () ->
    @jsonName
    
  ###* 
  @returns a mongoose schema.
  ###
  mongooseSchema: () ->
    def = {}
    for p in @properties
      def[p.mongooseName()] =
        type : p.moongooseDataType()
    #console.log "#######"
    #console.log def
    #console.log "#######"
    
    ms = new mongoose.Schema(def)
    ms