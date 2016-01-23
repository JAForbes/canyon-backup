
ductMakeChanged = (duct) =>
	return "" if duct.nbnmat is duct.material
	return codedValues.actualconduittype[duct.material]

w = new WebPage 'ductMakeChanged',"Duct make not as per Planning Information"

w.writeCode ductMakeChanged.toString()

w.beginTable "NBN Material","TLS Material","Answer"

for k,duct of old_conduit[0..10]
	
	w.addToTable duct.nbnmat, duct.material, ductMakeChanged duct

w.endTable()
w.end()