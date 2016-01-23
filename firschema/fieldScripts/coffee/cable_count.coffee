cableCount = (duct) =>
	#count how many ids there are
	ids = duct.cableids.split ','
	if ids[0] is "-"
		return "0"
	else
		return (x for x in ids when not (x is '-')).length
	
w = new WebPage 'cable_count',"Cable Count"
w.writeCode cableCount.toString()
w.beginTable "Cable ID's","Cable Count"

ids = []

for k,duct of old_conduit[0..100] when not (duct.cableids is '-')
	ids.push duct.cableids
	duct.cableids = ids.join(',')
	w.addToTable duct.cableids, cableCount duct
	lastDuct = duct
lastDuct.cableids = "-"
w.addToTable duct.cableids, cableCount lastDuct
w.endTable()

w.end()