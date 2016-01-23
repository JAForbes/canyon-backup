w = new WebPage 'conduit_material_and_diameter','Conduit Material and Diameter'

processedRoutes = []

sameRouteAs = (duct) =>
	ducts = []
	if example_duct_data?
	  for k,otherDuct of old_conduit
	  	if otherDuct.routeid is duct.routeid
	  		ducts.push otherDuct
	return ducts

conduitProfile = (duct) =>
	if duct?
		if duct.subductnum is "0"
			duct.subductnum = ""
		return "#{duct.nestcolumn}#{duct.nestrow}#{duct.subductnum}:#{duct.material}#{duct.diameter}:#{duct.fill}%"


nestProfile = (duct) =>
	nest = conduitProfile duct
	otherDucts = sameRouteAs duct
	for otherDuct in otherDucts
		nest+= ","+conduitProfile otherDuct
	return nest

w.writeWarning """This example uses multiple function definitions that are not displayed here.
Please view the source code file."""

w.writeCode nestProfile

w.beginTable "Route ID","Nest Profile"

for duct in old_conduit
	if duct.routeid not in processedRoutes
  	w.addToTable duct.routeid, nestProfile duct
  	processedRoutes.push duct.routeid
  if processedRoutes.length > 10
  	break

w.endTable()
w.end()