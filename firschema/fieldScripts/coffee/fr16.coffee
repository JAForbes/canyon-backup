w = new WebPage 'fr16',"FR16"

fr16 = (duct) =>
	return duct.fr16 if duct.fr16 is "Y"
	""

w.writeCode fr16.toString()
w.end()