w = new WebPage 'pitNameChanged',"Actual existing Pit size and type different from Planning information"

pitNameChanged = (pit) =>
	return "Y" if tlspitname is not actpitname
	""

w.writeCode pitNameChanged.toString()

w.end()