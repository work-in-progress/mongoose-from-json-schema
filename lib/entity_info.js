(function() {
  var _;
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
    return EntityInfo;
  })();
}).call(this);
