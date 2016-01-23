w = new WebPage 'fr9',"FR9"

fr9 = (duct) =>
	return duct.fr09 if duct.fr09 is "Y"
	""

w.writeCode fr9.toString()
w.end()