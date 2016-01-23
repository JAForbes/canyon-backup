// Generated by CoffeeScript 1.6.3
(function() {
  var codedValues, csv, ducts, fs, headerRow;

  if (typeof root !== "undefined" && root !== null) {
    /*
    Converts a csv definition of the Coded Values Schema to a
    Javascript Object
    
    This file runs on the server via node.js and generates
    a javascript file called codedValues.js.
    This script attached an object to the DOM called codedValues
    that can then be interacted with via other scripts.
    */

    fs = require("fs");
    csv = require("csv");
    codedValues = {};
    fs = require("fs");
    csv = require("csv");
    codedValues = {};
    ducts = [];
    headerRow = void 0;
    csv().from.stream(fs.createReadStream("./duct.csv")).on('record', function(row, index) {
      var cell, duct, i;
      if (headerRow === void 0) {
        return headerRow = row;
      } else {
        duct = {};
        for (i in row) {
          cell = row[i];
          console.log(headerRow[i], cell);
          duct[headerRow[i]] = cell;
        }
        return ducts.push(duct);
      }
    }).on('end', function(count) {
      var codedValuesCoffee, json;
      json = JSON.stringify(ducts);
      /*
      generate coffeescript file to make the json accessible
      to the DOM
      */

      codedValuesCoffee = "if window?\n  json = '" + json + "'\n  window.example_duct_data = JSON.parse(json)";
      fs.writeFile("./duct.coffee", codedValuesCoffee, function(err) {
        if (err) {
          return console.log(err);
        } else {

        }
      });
      return console.log("The file was saved!");
    });
  }

}).call(this);
