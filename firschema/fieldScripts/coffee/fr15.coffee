w = new WebPage 'fr15',"FR15"

fr15 = (duct) =>
	return duct.fr15 if duct.fr15 is "Y"
	""

w.writeCode fr15.toString()
w.end()