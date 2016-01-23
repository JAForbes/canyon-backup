w = new WebPage 'unfit',"Unfit"

unfit = (duct) =>
	["Y" if duct.scopestate is "6"]+''

w.writeCode unfit.toString()

w.end()