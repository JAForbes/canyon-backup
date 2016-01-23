
ductSizeChanged = (duct) =>
	return "" if duct.nbndiamtr is duct.diameter
	return "Y"

w = new WebPage 'ductSizeChanged',"Duct size not as per Planning Information"

w.writeCode ductSizeChanged.toString()

w.beginTable "NBN Diamater","TLS Diamater","Answer"

for k,duct of old_conduit[0..10]
	if k%4 is 0
	  duct.diameter = "20"
	w.addToTable duct.nbndiamtr, duct.diameter, ductSizeChanged duct

w.endTable()
w.end()