w = new WebPage 'fr10',"FR10"

fr10 = (duct) =>
	return duct.fr10 if duct.fr10 is "Y"
	""

w.writeCode fr10.toString()
w.end()