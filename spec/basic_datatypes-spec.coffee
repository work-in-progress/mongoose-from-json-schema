vows = require 'vows'
assert = require 'assert'
mongoose = require 'mongoose'

main = require '../lib/index'
specHelper = require './spec_helper'
specHelper.connectDatabase()

vows.describe("basic_datatypes")
  .addBatch
    "CLEANUP TEMP":
      topic: () ->
        specHelper.cleanTmpFiles []
      "THEN IT SHOULD BE CLEAN :)": () ->
        assert.isTrue true      
  .addBatch
    "CLEANING DATABASE" :
      topic: () -> 
        specHelper.cleanDatabase @callback
        return
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
        assert.isNotNull @xx.entityInfos['BasicDataTypeTest']
      "THEN it's jsonName should be set" : (err,newEntity) ->
        assert.equal @xx.entityInfos['BasicDataTypeTest'].jsonName ,"BasicDataTypeTest"
      "THEN it's propertyInfos count should be 4"  : (err,newEntity) ->
        assert.equal newEntity.propertyInfos.length ,4
      "THEN it's string property should return String"  : (err,newEntity) ->
        assert.equal newEntity.property("stringValue").moongooseDataType() ,String
      "THEN it should be able to create a schema"  : (err,newEntity) ->
        assert.instanceOf newEntity.mongooseSchema(),mongoose.Schema
      "THEN each property should be mongoose compatible"  : (err,newEntity) ->
        for p in newEntity.propertyInfos
          assert.isTrue p.isMongooseCompatible()
      "THEN each property should export a mongoose definition"  : (err,newEntity) ->
        for p in newEntity.propertyInfos
          assert.isNotNull p.mongooseSchemaDefinition()        
      "THEN that schema needs to have a stringValue member"  : (err,newEntity) ->
        #console.log newEntity.mongooseSchema().path('stringValue')
        assert.equal newEntity.mongooseSchema().path('stringValue').path,"stringValue"
      "THEN that schema needs to have a integerValue member"  : (err,newEntity) ->
        assert.equal newEntity.mongooseSchema().path('integerValue').path,"integerValue"
      "THEN that schema needs to have a booleanValue member"  : (err,newEntity) ->
        assert.equal newEntity.mongooseSchema().path('booleanValue').path,"booleanValue"
      "THEN that schema needs to have a numberValue member"  : (err,newEntity) ->
        assert.equal newEntity.mongooseSchema().path('numberValue').path,"numberValue"

      "THEN the schema should be found through the main entry point": (err,newEntity) ->
        assert.isNotNull @xx.mongooseSchema("BasicDataTypeTest")
  .addBatch
     "WHEN retrieving a model for the previously created schema" :
       topic: () -> 
         @xx =  new main.JsonSchemaToMongoose()
         json = specHelper.loadJsonFixture "basic_datatypes.json"
         @xx.addJsonSchema null, json, (err,newEntity)=>
            @BasicDataTypeTest = @xx.mongooseModel("BasicDataTypeTest")
            @callback(err,newEntity)
         
         return
       "THEN it should have been created": (err,newEntity) ->
         assert.isNotNull @BasicDataTypeTest
        
  .export module
