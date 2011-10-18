main = require '../lib/index'

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

