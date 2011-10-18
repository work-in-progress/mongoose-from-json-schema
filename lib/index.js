(function() {
  exports.JsonSchemaToMongoose = (function() {
    JsonSchemaToMongoose.prototype.mongoose = require('mongoose');
    JsonSchemaToMongoose.prototype.color = require('colors');
    JsonSchemaToMongoose.prototype.mongooseTypes = require("mongoose-types");
    function JsonSchemaToMongoose(opts) {
      if (opts == null) {
        opts = {};
      }
    }
    JsonSchemaToMongoose.prototype.addSchema = function(name, schema, cb) {};
    return JsonSchemaToMongoose;
  })();
}).call(this);
