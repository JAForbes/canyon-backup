w = new WebPage 'fr2',"FR2"

fr2 = (duct) =>
	return duct.fr02 if duct.fr02 is "Y"
	""

w.writeCode fr2.toString()
w.end()