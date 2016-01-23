#used to output to webpage
w = new WebPage 'enclosureCount',"Enclosure Count"

w.writeCode """/* The count of all of the transit joints i.e.
  			   if there were a TJL column in the template */
  			   enclosureCount = tjl"""

w.end()