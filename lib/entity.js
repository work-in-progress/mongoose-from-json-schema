(function() {
  /**
  Reprents a single entity. Internally used to store mapping info and stuff.
  */  exports.Entity = (function() {
    Entity.prototype.jsonName = null;
    function Entity(jsonName, originalSchema) {
      this.jsonName = jsonName;
      this.originalSchema = originalSchema;
      this.properties = [];
    }
    return Entity;
  })();
}).call(this);
