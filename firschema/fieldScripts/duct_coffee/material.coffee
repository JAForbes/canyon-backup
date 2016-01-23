w = new WebPage 'material','Material'

material = (duct) =>
	return (duct.nbnmat or duct.material or "X")+(duct.nbndiamtr or duct.diameter)

w.writeCode material.toString()

w.beginTable "NBN Material","Material","NBN Diameter","Diameter","Output"

for duct in old_conduit[0..10]
	w.addToTable duct.nbnmat, duct.material, duct.nbndiamtr, duct.diameter, material duct

w.endTable()

w.end()