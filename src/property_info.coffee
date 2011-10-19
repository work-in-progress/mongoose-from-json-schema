
_ = require "underscore"

###*
Reprents a single property. Internally used to store mapping info and stuff.
###
class exports.PropertyInfo
  jsonName : null
  
  constructor: (@jsonName,@propertySchema) ->
  
  ###* 
  @returns the name to be used within mongoose
  ###
  mongooseName: () ->
    @jsonName
  
  ###*
  Analyses the schema and returns the mongoose data type
  ###
  moongooseDataType: () ->
    dt = @propertySchema.type.toLowerCase()
    switch dt
      when "string" then String
      when "number" then Number
      when "integer" then Number # AKA pain and suffering
      when "boolean" then Boolean
      else
        null
        
  ###*
  Checks if this property is actually compatible with 
  mongoose. For now returns true when the data type checks out.
  ###
  isMongooseCompatible: () ->
    @moongooseDataType() != null
  
  ###* 
  Creates a mongoose schema definition from this property info.
  This is where some of the magic happens.
  ###
  mongooseSchemaDefinition: () ->
    res =
      type : @moongooseDataType()
    
    res