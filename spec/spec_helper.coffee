main = require '../lib/index'
fs = require 'fs'
mongoose = require 'mongoose'
DatabaseCleaner = require 'database-cleaner'

dbUrl = 'mongodb://localhost/pts_test' 


module.exports = 
    
  setup: (cb) ->
    cb null
    
  fixturePath: (fileName) ->
    "#{__dirname}/fixtures/#{fileName}"

  tmpPath: (fileName) ->
    "#{__dirname}/../tmp/#{fileName}"

  cleanTmpFiles: (fileNames) ->
    for file in fileNames
      try
        fs.unlinkSync @tmpPath(file)
      catch ignore

  loadJsonFixture: (fixtureName) ->
    data = fs.readFileSync @fixturePath(fixtureName), "utf-8"
    JSON.parse data
    
  database : dbUrl

  # Connect to the test database.
  connectDatabase: () ->
    mongoose.connect dbUrl

  cleanDatabase : (cb) ->
    databaseCleaner = new DatabaseCleaner('mongodb')
    databaseCleaner.clean mongoose.createConnection(dbUrl).db, (err) ->
      return cb(err) if err?
      cb null
        