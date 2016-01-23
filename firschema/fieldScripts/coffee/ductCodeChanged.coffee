ductCodeChanged = (duct) =>
	nbnStr = "#{duct.nbnnestcol}#{duct.nbnnestrow}#{duct.nbnsubduct}".replace "0",""
	tlsStr = "#{duct.nestcolumn}#{duct.nestrow}#{duct.subductnum}".replace "0",""
	return [tlsStr unless nbnStr is tlsStr]+""

w = new WebPage 'ductCodeChanged','Alternative Duct Section'

w.beginTable "NBN","Scoper","Answer"

for k,duct of old_conduit[0..10]
	if k % 4 is 0
		duct.nestrow = 'B'
	w.addToTable "#{duct.nbnnestcol}#{duct.nbnnestrow}#{duct.nbnsubduct}","#{duct.nestcolumn}#{duct.nestrow}#{duct.subductnum}", ductCodeChanged duct

w.endTable()
w.end()