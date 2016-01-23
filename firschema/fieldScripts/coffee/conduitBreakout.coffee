#Search for id in newundergroundroute table to check how many occurences there are in either start or end nodes of new routes."
#If there is any occurences, return "Y", else return ""
getConduitBreakout = (pit) =>	
  for k,route of newugroute
    if pit.id is route.startnode
    	return "Y"
    else if pit.id is route.endnode
      return "Y"
  return ""

w = new WebPage 'conduitBreakout',"Conduit Breakout Required"
w.writeCode getConduitBreakout.toString()
w.beginTable "Pit ID","Conduit Breakout Required"

for pit in old_pit[10..20]
  w.addToTable pit.id, getConduitBreakout pit

w.endTable()
w.end()