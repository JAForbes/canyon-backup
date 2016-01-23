w = new WebPage 'fr6',"FR6"

fr6 = (duct) =>
	return duct.fr06 if duct.fr06 is "Y"
	""

w.writeCode fr6.toString()
w.end()