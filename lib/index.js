(function() {
  exports.JsonSchemaToMongoose = (function() {
    function JsonSchemaToMongoose() {}
    JsonSchemaToMongoose.prototype.mongoose = require('mongoose');
    JsonSchemaToMongoose.prototype.color = require('colors');
    JsonSchemaToMongoose.prototype.mongooseTypes = require("mongoose-types");
    return JsonSchemaToMongoose;
  })();
}).call(this);
