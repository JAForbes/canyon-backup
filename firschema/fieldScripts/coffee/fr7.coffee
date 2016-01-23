w = new WebPage 'fr7',"FR7"

fr7 = (duct) =>
	return duct.fr07 if duct.fr07 is "Y"
	""

w.writeCode fr7.toString()
w.end()