w = new WebPage 'notperplan','Location not as per Planning Information (Y/N)'

notperplan = (duct) =>
	if duct.notperplan is "Y"
		return "Y"
	else
		return ""

w.writeWarning "Not a direct translation.  Do not return 'N'"
w.writeCode notperplan.toString()

w.end()