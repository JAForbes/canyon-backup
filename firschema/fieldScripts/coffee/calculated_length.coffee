if document?
  w = new WebPage('calculated_length',"Calculated Length")

  w.writeCode """/* One to one translation */
	calculated_length = nbnlength"""
w.end()