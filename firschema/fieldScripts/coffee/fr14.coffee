w = new WebPage 'fr14',"FR14"

fr14 = (duct) =>
	return duct.fr14 if duct.fr14 is "Y"
	""

w.writeCode fr14.toString()
w.end()