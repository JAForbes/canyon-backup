mainAreas = ["zero","bogoodturf","boconcrete","bobituasph","bobrickpav"]
inroadways = ["Y",""]

surfaceType = (mainArea,inroadway) =>    
  switch mainArea
    when "zero"
      value = "Unspecified"
    when "bogoodturf"
      value = "Grass"
    when "boconcrete"
        value = "Concrete"
    when "bobituasph"
        value = "Bitumen"
    when "bobrickpav"
      value = "Paver"

  switch mainArea 
    when "bobituasph","boconcrete"
      if inroadway is "Y"
        value += " roadway"

  return value;

w = new WebPage 'surfaceType',"Surface Type"

w.writeHtml """
<div class="alert">
  <button type="button" class="close" data-dismiss="alert">&times;</button>
  <strong>Warning!</strong> Assumed Function findLargestArea() 
</div>
"""
w.writeCode """
findLargestArea(areas...) /* returns name of input field with largest value as string, or if all areas are zero it returns "zero" */
mainArea = findLargestArea(bogoodturf, boconcrete, bobituasph, bobrickpav)


"""+surfaceType.toString()

w.beginTable "Main Area","In Roadway","Return"
  
for mainArea in mainAreas
  for inroadway in inroadways
    w.addToTable mainArea,inroadway,surfaceType mainArea,inroadway

w.endTable()
w.end()