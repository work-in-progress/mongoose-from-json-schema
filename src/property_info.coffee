
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
  textTrimming: null || "trim"
  textTransform: null || "uppercase" || "lowercase"
  pattern: "" optional, a regex pattern
  minLength: 0 optional, a positive integer
  maxLength: 1000 optional, a positive integer

  # Custom Properties
  index, unique,sparse
  enum: 
  
  ---
  format: 
  ###
  convert: (propertySchema) ->
    pattern = if propertySchema.pattern then new RegExp(propertySchema.pattern) else null
    validators = []
    
    if propertySchema.minLength 
      validators.push (v) -> v.length >= propertySchema.minLength

    if propertySchema.maxLength 
      validators.push (v) -> v.length <= propertySchema.maxLength
    
    # This assumes that we have string values inside the enum, we might
    # want to check that
    enums = null
    if propertySchema.enum && propertySchema.enum.length > 0
      enums = []
      enums.push x for x in propertySchema.enum
      
    res =
      type: String
      title: propertySchema.title || null
      description: propertySchema.description || null 
      required : !!propertySchema.required
      default: propertySchema.default || null
      validate : validators      
      lowercase: "#{propertySchema.textTransform}".toLowerCase() == "lowercase" 
      uppercase: "#{propertySchema.textTransform}".toLowerCase() == "uppercase"
      trim:!!propertySchema.textTrimming      
      match: pattern
      enum: enums
      index : !!propertySchema.uniqueIndex || !!propertySchema.index
      unique :!!propertySchema.uniqueIndex
      sparse: !!propertySchema.sparseIndex 
    res