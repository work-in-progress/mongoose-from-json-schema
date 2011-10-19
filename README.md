## About mongoose-from-json-schema

Transform a json-schema into a mongoose schema.

THIS IS NOT DONE YET. DON'T USE YET

[![Build Status](https://secure.travis-ci.org/scottyapp/mongoose-from-json-schema.png)](http://travis-ci.org/scottyapp/mongoose-from-json-schema.png)


## Notes for later
    "mongoose-auth" : ">= 0.0.11",
    "mongoose-helpers" : ">= 0.1.0",
    "mongoose-closures" : ">= 0.0.1",
    "mongoose-spatial" : ">= 0.0.1",
    "mongoose-temporal" : ">= 0.0.1",
    "mongoose-dbref" : ">= 0.0.2",

# Install

npm install mongoose-from-json-schema

## Usage


### Coffeescript

	jstm = require("mongoose-from-json-schema")
	bag = new jstm.JsonSchemaToMongoose()
	bag.addJsonSchema "MyModelName", {... json schema ...}, (err) ->
		MyModelName = bag.mongooseModel("MyModelName")
 
### Javascript

	var bag, jstm;
	jstm = require("mongoose-from-json-schema");
	bag = new jstm.JsonSchemaToMongoose();
	bag.addJsonSchema("MyModelName", {}, function(err) {
  	var MyModelName;
  	return MyModelName = bag.mongooseModel("MyModelName");
	});

## Advertising :)

Check out 

* http://freshfugu.com 
* http://scottyapp.com

Follow us on Twitter at 

* @getscottyapp
* @freshfugu 
* @martin_sunset

and like us on Facebook please. Every mention is welcome and we follow back.

## Trivia

Some latin music this time.

## Release Notes



### 0.0.1

* First version

## Internal Stuff

* npm run-script watch

# Publish new version

* Change version in package.json
* git tag -a v0.0.1 -m 'version 0.0.1'
* git push --tags
* npm publish

## Contributing to mongoose-from-json-schema
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the package.json, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 Martin Wawrusch. See LICENSE for
further details.


