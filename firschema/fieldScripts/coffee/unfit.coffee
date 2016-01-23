w = new WebPage 'unfit',"Unfit"

unfit = (duct) =>
	["Y" if duct.scopestate is "3"]+''

w.writeCode unfit.toString()

w.end()