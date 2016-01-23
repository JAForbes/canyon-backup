w = new WebPage 'phototaken',"Photograph Taken"

phototaken = (duct) =>
	phototaken if phototaken is "Y"
	""

w.writeCode phototaken.toString()

w.end()