main = require '../lib/index'
fs = require 'fs'

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