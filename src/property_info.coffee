
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
    dt = @propertySchema.type.toLowerCase()
    switch dt
       when "string" then new StringPropertyConverter().convert(@propertySchema)
       else
        res =
          type : @moongooseDataType()
        res

###*
A property converter that converts string type.
###
class StringPropertyConverter
  
  ###*
  The property schema that is accepted looks like this:
  type: "String"
  title:
  description:
  required:
  default: 
  
  
  pattern: "" optional, a regex pattern
  minLength: 0 optional, a positive integer
  maxLength: 1000 optional, a positive integer
  # Custom Properties
  textTrimming: null || "trim"
  textTransform: null || "uppercase" || "lowercase"
  index, unique,sparse
  ---
  format: 
  enum: 
  
  ###
  convert: (propertySchema) ->
    
    res =
      type: String
      title: propertySchema.title || null
      description: propertySchema.description || null 
      required : !!propertySchema.required
      default: propertySchema.default || null
      
      lowercase: false
      uppercase: false
      trim:false
      match:null
      enum: null
    res