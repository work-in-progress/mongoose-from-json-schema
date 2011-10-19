(function() {
  var _;
  _ = require("underscore");
  /**
  Reprents a single property. Internally used to store mapping info and stuff.
  */
  exports.PropertyInfo = (function() {
    PropertyInfo.prototype.jsonName = null;
    function PropertyInfo(jsonName, propertySchema) {
      this.jsonName = jsonName;
      this.propertySchema = propertySchema;
    }
    /** 
    @returns the name to be used within mongoose
    */
    PropertyInfo.prototype.mongooseName = function() {
      return this.jsonName;
    };
    /**
    Analyses the schema and returns the mongoose data type
    */
    PropertyInfo.prototype.moongooseDataType = function() {
      var dt;
      dt = this.propertySchema.type.toLowerCase();
      switch (dt) {
        case "string":
          return String;
        case "number":
          return Number;
        case "integer":
          return Number;
        case "boolean":
          return Boolean;
        default:
          return null;
      }
    };
    /**
    Checks if this property is actually compatible with 
    mongoose. For now returns true when the data type checks out.
    */
    PropertyInfo.prototype.isMongooseCompatible = function() {
      return this.moongooseDataType() !== null;
    };
    /** 
    Creates a mongoose schema definition from this property info.
    This is where some of the magic happens.
    */
    PropertyInfo.prototype.mongooseSchemaDefinition = function() {
      var res;
      res = {
        type: this.moongooseDataType()
      };
      return res;
    };
    return PropertyInfo;
  })();
}).call(this);
