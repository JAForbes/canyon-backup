if document?
  w = new WebPage("test","Test")  
  w.beginTable("Collar","Lid","Pit","Comment")
  
  yMatrix = [
  	["","",""]
  	["Y","",""]
  	["","Y",""]
  	["","","Y"]
  	["Y","Y",""]
  	["","Y","Y"]
  	["Y","","Y"]
  	["Y","Y","Y"]
  ]
  
  for k,row of yMatrix

  	elements = []
  	[damagecolr,damagelid, damagepit] = row
  	if damagecolr is "Y"
  		elements.push "Collar"
  	if damagelid is "Y"
  		elements.push "Lid"
  	if damagepit is "Y"
  		elements.push "Pit Body"

  	switch elements.length
  	  when 1
  	    comment = "#{elements[0]} damaged"
  	  when 2
  	    comment = "#{elements[0]} and #{elements[1]} damaged"
  	  when 3
  	    comment = "#{elements[0]}, #{elements[1]} and #{elements[2]} damaged"
  	  else
  	if comment?
  	  row.push comment
  	  w.addToTable row...
    
	
  w.endTable()
  w.end()