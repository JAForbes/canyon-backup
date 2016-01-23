if document?
  w = new WebPage('systemID',"System ID")

  w.writeCode """/* system_id not provided in NDD GML, default value to 0 on FIR */
	system_id = 0"""

  w.end()