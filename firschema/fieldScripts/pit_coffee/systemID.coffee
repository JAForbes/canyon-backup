if document?
  w = new WebPage("systemID","System ID")
  code = 
  	"""/* system_id not provided in NDD GML, default value to 0 on FIR */
	systemID = 0"""
  w.writeCode code
  w.end()