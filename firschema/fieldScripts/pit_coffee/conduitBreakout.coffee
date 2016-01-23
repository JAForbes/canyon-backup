#Search for id in newundergroundroute table to check how many occurences there are in either start or end nodes of new routes."
#If there is any occurences, return "Y", else return ""
getConduitBreakout = (pit,route) =>	
  if pit.id is route.startNode
  	return "Y"
  else if pit.id is route.endNode
    return "Y"
  return ""

w = new WebPage 'conduitBreakout',"Conduit Breakout Required"
w.writeCode getConduitBreakout.toString()
w.beginTable "Pit ID","Route Start Node", "Route End Node","Conduit Breakout Required"

ugRoute1 =
  startNode: 123
  endNode: 456

ugRoute2 = 
  startNode: 456
  endNode: 123

pit1 =
  id: 123

pit2 = 
  id: 456

pit3 = 
  id: 789

pits = [pit1,pit2,pit3]

ugRoutes = [ugRoute1,ugRoute2]

for pit in pits
  for route in ugRoutes
  	w.addToTable pit.id, route.startNode, route.endNode, getConduitBreakout pit,route

w.endTable()
w.end()