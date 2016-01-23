notLocated = (duct) =>
	if duct.scopestate is 6 
		return "Y"
	return ""

w = new WebPage 'notLocated','Not Located'
w.writeCode notLocated.toString()
w.end()