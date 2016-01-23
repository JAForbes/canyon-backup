if document?
  w = new WebPage('measured_length',"Measured Length")

  w.writeCode """/* One to one translation */
	measured_length = nbnlength"""
w.end()