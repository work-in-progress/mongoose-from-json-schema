(function() {
  var mongoose, _;
  mongoose = require('mongoose');
  _ = require("underscore");
  /**
  Reprents a single entity. Internally used to store mapping info and stuff.
  */
  exports.EntityInfo = (function() {
    EntityInfo.prototype.jsonName = null;
    function EntityInfo(jsonName, originalSchema) {
      this.jsonName = jsonName;
      this.originalSchema = originalSchema;
      this.properties = [];
    }
    EntityInfo.prototype.property = function(name) {
      return _.select(this.properties, function(x) {
        return x.jsonName === name;
      })[0];
    };
    EntityInfo.prototype.mongooseModelName = function() {
      return this.jsonName;
    };
    /** 
    @returns a mongoose schema.
    */
    EntityInfo.prototype.mongooseSchema = function() {
      var def, ms, p, _i, _len, _ref;
      def = {};
      _ref = this.properties;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        p = _ref[_i];
        def[p.mongooseName()] = {
          type: p.moongooseDataType()
        };
      }
      ms = new mongoose.Schema(def);
      return ms;
    };
    return EntityInfo;
  })();
}).call(this);
