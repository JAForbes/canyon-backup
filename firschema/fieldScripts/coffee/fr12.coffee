w = new WebPage 'fr12',"FR12"

fr12 = (duct) =>
	return duct.fr12 if duct.fr12 is "Y"
	""

w.writeCode fr12.toString()
w.end()