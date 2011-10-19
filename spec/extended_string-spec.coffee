vows = require 'vows'
assert = require 'assert'
mongoose = require 'mongoose'

main = require '../lib/index'
specHelper = require './spec_helper'
specHelper.connectDatabase()

vows.describe("extended_string")
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
    "WHEN adding a full blown string property and creating a model from it" :
       topic: () -> 
         @xx =  new main.JsonSchemaToMongoose()
         json = specHelper.loadJsonFixture "extended_string.json"
         @xx.addJsonSchema null, json, (err,newEntity)=>
            @ExtendedString = @xx.mongooseModel("ExtendedString")
            @callback(err,newEntity)
         
         return
       "THEN it should have been created": (err,newEntity) ->
         assert.isNotNull @ExtendedString
        
  .export module
