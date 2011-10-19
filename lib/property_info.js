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
    textTrimming: null || "trim"
    textTransform: null || "uppercase" || "lowercase"
    pattern: "" optional, a regex pattern
    minLength: 0 optional, a positive integer
    maxLength: 1000 optional, a positive integer
    
    # Custom Properties
    index, unique,sparse
    enum: 
    
    ---
    format: 
    */
    StringPropertyConverter.prototype.convert = function(propertySchema) {
      var enums, pattern, res, validators, x, _i, _len, _ref;
      pattern = propertySchema.pattern ? new RegExp(propertySchema.pattern) : null;
      validators = [];
      if (propertySchema.minLength) {
        validators.push(function(v) {
          return v.length >= propertySchema.minLength;
        });
      }
      if (propertySchema.maxLength) {
        validators.push(function(v) {
          return v.length <= propertySchema.maxLength;
        });
      }
      enums = null;
      if (propertySchema["enum"] && propertySchema["enum"].length > 0) {
        enums = [];
        _ref = propertySchema["enum"];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          x = _ref[_i];
          enums.push(x);
        }
      }
      res = {
        type: String,
        title: propertySchema.title || null,
        description: propertySchema.description || null,
        required: !!propertySchema.required,
        "default": propertySchema["default"] || null,
        validate: validators,
        lowercase: ("" + propertySchema.textTransform).toLowerCase() === "lowercase",
        uppercase: ("" + propertySchema.textTransform).toLowerCase() === "uppercase",
        trim: !!propertySchema.textTrimming,
        match: pattern,
        "enum": enums,
        index: !!propertySchema.uniqueIndex || !!propertySchema.index,
        unique: !!propertySchema.uniqueIndex,
        sparse: !!propertySchema.sparseIndex
      };
      return res;
    };
    return StringPropertyConverter;
  })();
}).call(this);
