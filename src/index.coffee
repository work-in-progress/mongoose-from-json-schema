
entityInfo = require './entity_info'
propertyInfo = require './property_info'
mongoose = require 'mongoose'
color = require 'colors'
mongooseTypes = require "mongoose-types"
_ = require "underscore"

###*
Encapsulates the primary functionality for this module.
###
class exports.JsonSchemaToMongoose

  ###*
  Initializes a new instance of the @see JsonSchemaToMongoose class.
  ###
  constructor: (opts = {}) ->
    @entityInfos = {}
    
    
  ###*
  Add a json schema fragment. If name is null then the fragment must contain a valid 
  name. 
  ###
  addJsonSchema: (name,schema,cb) ->
    name = @_extractName(name,schema)
    console.log name
    console.log @
    sc = @entityInfos[name] = new entityInfo.EntityInfo(name,schema) 
    
    # WIP
    
    _.each (schema.properties || {}), (value,key,list) =>
      sc.propertyInfos.push new propertyInfo.PropertyInfo key,value
      
    cb null,sc
    #schema
    
  ###*
  returns a model against the current database connection, or mongoose 
  itself if none is set.
  ###
  mongooseModel: (name,connection) ->
    schema = @mongooseSchema(name)
    modelName = @entityInfos[name].mongooseModelName()
    
    if connection 
      connection.model(modelName,schema) 
    else 
      mongoose.model(modelName,schema)
      
  ###*
  returns a mongoose schema for a previously added json schema.
  ###
  mongooseSchema: (name) ->
     @entityInfos[name].mongooseSchema()
  
  # super simplistic version for now.
  _extractName: (name,schema) ->
    return name if name
    schema.name