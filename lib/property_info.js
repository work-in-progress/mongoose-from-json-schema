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
          return Integer;
        case "boolean":
          return Boolean;
        default:
          return null;
      }
    };
    return PropertyInfo;
  })();
}).call(this);
