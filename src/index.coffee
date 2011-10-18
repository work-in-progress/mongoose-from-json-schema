class exports.JsonSchemaToMongoose
  
  mongoose : require 'mongoose'
  color : require 'colors'
  mongooseTypes : require "mongoose-types"

  
  constructor: (opts = {}) ->
    
  
  addSchema: (name,schema,cb) ->
    