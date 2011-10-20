vows = require 'vows'
assert = require 'assert'
mongoose = require 'mongoose'

main = require '../lib/index'
specHelper = require './spec_helper'
specHelper.connectDatabase()

vows.describe("extended_integer")
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
    "WHEN adding a full blown integer property and creating a model from it" :
       topic: () -> 
         @xx =  new main.JsonSchemaToMongoose()
         json = specHelper.loadJsonFixture "extended_integer.json"
         @xx.addJsonSchema null, json, (err,newEntity)=>
            @ExtendedInteger = @xx.mongooseModel("ExtendedInteger")
            @callback(err,newEntity)
         
         return
       "THEN it should have been created": (err,newEntity) ->
         assert.isNotNull @ExtendedInteger
       "THEN it should have been 3 validators": (err,newEntity) ->
         #for x in @ExtendedInteger.schema.path("integerValue").validators
         #  console.log x           
         assert.equal @ExtendedInteger.schema.path("integerValue").validators.length,3
        
  .export module
