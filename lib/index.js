(function() {
  var color, entityInfo, mongoose, mongooseTypes, propertyInfo, _;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  entityInfo = require('./entity_info');
  propertyInfo = require('./property_info');
  mongoose = require('mongoose');
  color = require('colors');
  mongooseTypes = require("mongoose-types");
  _ = require("underscore");
  /**
  Encapsulates the primary functionality for this module.
  */
  exports.JsonSchemaToMongoose = (function() {
    /**
    Initializes a new instance of the @see JsonSchemaToMongoose class.
    */    function JsonSchemaToMongoose(opts) {
      if (opts == null) {
        opts = {};
      }
      this.schemas = {};
    }
    /**
    Add a json schema fragment. If name is null then the fragment must contain a valid 
    name. 
    */
    JsonSchemaToMongoose.prototype.addJsonSchema = function(name, schema, cb) {
      var sc;
      name = this._extractName(name, schema);
      console.log(name);
      console.log(this);
      sc = this.schemas[name] = new entityInfo.EntityInfo(name, schema);
      _.each(schema.properties || {}, __bind(function(value, key, list) {
        return sc.properties.push(new propertyInfo.PropertyInfo(key, value));
      }, this));
      return cb(null, sc);
    };
    /**
    returns a model against the current database connection, or mongoose 
    itself if none is set.
    */
    JsonSchemaToMongoose.prototype.model = function(name) {};
    /**
    returns a mongoose schema for a previously added json schema.
    */
    JsonSchemaToMongoose.prototype.schema = function(name) {};
    JsonSchemaToMongoose.prototype._extractName = function(name, schema) {
      if (name) {
        return name;
      }
      return schema.name;
    };
    return JsonSchemaToMongoose;
  })();
}).call(this);
