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

  ducts = []

  headerRow = undefined

  #read the csv file
  csv()
  .from.stream(fs.createReadStream("./oldConduit_1.2.csv"))


  #load codedValues object
  .on 'record', (row,index) ->
  	if headerRow is undefined
      headerRow = row
    else
      duct = {}
      
      for i,cell of row
        duct[headerRow[i]] = cell
      ducts.push duct
  #convert codedValues object to JSON
  .on 'end', (count) ->
    json = JSON.stringify(ducts)

    ###
    generate coffeescript file to make the json accessible
    to the DOM
    ###
    codedValuesCoffee = """
  						if window?
  						  json = '#{json}'
  						  window.old_conduit = JSON.parse(json)
  					  """

    #Write generated script out					  
    fs.writeFile "./old_conduit.coffee", codedValuesCoffee, (err) ->
      if err 
        console.log err
      else
  	  console.log "The file was saved!"
