if root?
  ###
  Converts a csv definition of the Coded Values Schema to a
  Javascript Object

  This file runs on the server via node.js and generates
  a javascript file called codedValues.js.
  This script attached an object to the DOM called codedValues
  that can then be interacted with via other scripts.

  ###
  fs = require("fs")
  csv = require("csv")
  codedValues = {}

  fs = require("fs")
  csv = require("csv")
  codedValues = {}

  #read the csv file
  csv()
  .from.stream(fs.createReadStream("../csv/codedValues.csv"))

  #load codedValues object
  .on 'record', (row,index) ->
  	if codedValues[row[0]] is undefined
        codedValues[row[0]] = {}
      codedValues[row[0]][row[1]] = [row[2]]
      #convert mishandled squared character to "^2"
      codedValues[row[0]][row[1]] = codedValues[row[0]][row[1]].toString().replace "?","^2"

  #convert codedValues object to JSON
  .on 'end', (count) ->
    console.log codedValues
    json = JSON.stringify(codedValues)

    ###
    generate coffeescript file to make the json accessible
    to the DOM
    ###
    codedValuesCoffee = """
  						if window?
  						  json = '#{json}'
  						  window.codedValues = JSON.parse(json)
  					  """

    #Write generated script out					  
    fs.writeFile "./codedValues.coffee", codedValuesCoffee, (err) ->
      if err 
        console.log err
      else
  	  console.log "The file was saved!"
