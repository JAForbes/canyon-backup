cableCount = (duct) =>
	#count how many ids there are
	ids = duct.cableids.split ','
	if ids[0] is "-"
		return "0"
	else
		return ids.length
	
w = new WebPage 'cable_count',"Cable Count"
w.writeCode cableCount.toString()
w.beginTable "Cable ID's","Cable Count"

for k,duct of old_conduit[0..5]
	w.addToTable duct.cableids, cableCount duct

w.endTable()

w.end()