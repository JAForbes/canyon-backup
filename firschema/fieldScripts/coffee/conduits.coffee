w = new WebPage "conduits","Conduits"

countConduits = (duct) =>
	(d for k,d of old_conduit when d.routeid is duct.routeid).length
	
w.writeCode countConduits.toString()

w.beginTable "duct.routeid","Conduit Count"
for k,duct of old_conduit[0..25]
	w.addToTable duct.routeid, countConduits duct

w.end()