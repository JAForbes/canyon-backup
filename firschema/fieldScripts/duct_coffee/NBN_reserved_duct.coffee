nbnReservedDuct = (duct) =>
	out = "#{duct.nbnnestcol}#{duct.nbnnestrow}#{duct.nbnsubduct}"
	out.replace "0",""

w = new WebPage 'NBN_reserved_duct','NBN Reserved Duct'

w.writeCode nbnReservedDuct.toString()

w.beginTable "Nest Col","Nest Row","Subduct","NBN Reserved Duct"

for duct in old_conduit[0..10]
	w.addToTable duct.nbnnestcol, duct.nbnnestrow, duct.nbnsubduct, nbnReservedDuct duct

w.endTable()

w.end()