if document?
  w = new WebPage('tls_id_conduit',"Telstra Conduit ID")

  w.writeCode """/* One to one translation */
	tls_id_conduit = conduitid"""
w.end()