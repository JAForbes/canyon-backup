w = new WebPage 'fr5',"FR5"

fr5 = (duct) =>
	return duct.fr05 if duct.fr05 is "Y"
	""

w.writeCode fr5.toString()
w.end()