(function() {
  var StringPropertyConverter, _;
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
      var dt, res;
      dt = this.propertySchema.type.toLowerCase();
      switch (dt) {
        case "string":
          return new StringPropertyConverter().convert(this.propertySchema);
        default:
          res = {
            type: this.moongooseDataType()
          };
          return res;
      }
    };
    return PropertyInfo;
  })();
  /**
  A property converter that converts string type.
  */
  StringPropertyConverter = (function() {
    function StringPropertyConverter() {}
    /**
    The property schema that is accepted looks like this:
    type: "String"
    title:
    description:
    required:
    default: 
    
    
    pattern: "" optional, a regex pattern
    minLength: 0 optional, a positive integer
    maxLength: 1000 optional, a positive integer
    # Custom Properties
    textTrimming: null || "trim"
    textTransform: null || "uppercase" || "lowercase"
    index, unique,sparse
    ---
    format: 
    enum: 
    
    */
    StringPropertyConverter.prototype.convert = function(propertySchema) {
      var res;
      res = {
        type: String,
        title: propertySchema.title || null,
        description: propertySchema.description || null,
        required: !!propertySchema.required,
        "default": propertySchema["default"] || null,
        lowercase: false,
        uppercase: false,
        trim: false,
        match: null,
        "enum": null
      };
      return res;
    };
    return StringPropertyConverter;
  })();
}).call(this);
