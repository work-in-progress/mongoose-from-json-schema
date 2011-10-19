vows = require 'vows'
assert = require 'assert'

main = require '../lib/index'
specHelper = require './spec_helper'
specHelper.connectDatabase()

vows.describe("integration_task")
  .addBatch
    "CLEANING DATABASE" :
      topic: () -> 
        specHelper.cleanDatabase @callback
        return
      "THEN IT SHOULD BE CLEAN :)": () ->
        assert.isTrue true
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
        @xx.addJsonSchema "hello", {},@callback
        return
      "THEN it should have been added": (err,newEntity) ->
        assert.isNotNull @xx.entityInfos['hello']
      "THEN it's jsonName should be set" : (err,newEntity) ->
        assert.equal @xx.entityInfos['hello'].jsonName ,"hello"
      "THEN it's propertyInfos count should be 0"  : (err,newEntity) ->
          assert.equal newEntity.propertyInfos.length ,0
      "THEN it's originalSchema object should be set"  : (err,newEntity) ->
          assert.isNotNull @xx.entityInfos['hello'].originalSchema
      
  .export module
