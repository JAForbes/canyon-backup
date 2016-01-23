w = new WebPage 'fr8',"FR8"

fr8 = (duct) =>
	return duct.fr08 if duct.fr08 is "Y"
	""

w.writeCode fr8.toString()
w.end()