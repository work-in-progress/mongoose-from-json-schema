vows = require 'vows'
assert = require 'assert'

main = require '../lib/index'
specHelper = require './spec_helper'

vows.describe("basic_datatypes")
  .addBatch
    "CLEANUP TEMP":
      topic: () ->
        specHelper.cleanTmpFiles []
      "THEN IT SHOULD BE CLEAN :)": () ->
        assert.isTrue true        
  .addBatch
    "SETUP" :
      topic: () -> 
        specHelper.setup @callback
        return
      "THEN IT SHOULD BE SET UP :)": () ->
        assert.isTrue true
  .addBatch
    "WHEN adding a json schema" :
      topic: () -> 
        @xx =  new main.JsonSchemaToMongoose()
        json = specHelper.loadJsonFixture "basic_datatypes.json"
        @xx.addJsonSchema null, json,@callback
        return
      "THEN it should have been added": (err,newEntity) ->
        assert.isNotNull @xx.schemas['BasicDatatypes']
      "THEN it's jsonName should be set" : (err,newEntity) ->
        assert.equal @xx.schemas['BasicDatatypes'].jsonName ,"BasicDatatypes"
      "THEN it's properties count should be 5"  : (err,newEntity) ->
          assert.equal newEntity.properties.length ,5
      "THEN it's string property should return String"  : (err,newEntity) ->
          assert.equal newEntity.property("stringValue").moongooseDataType() ,String
      
  .export module
