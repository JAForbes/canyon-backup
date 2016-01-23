if document?
  w = new WebPage('tls_id_route',"Telstra Route ID")

  w.writeCode """/* One to one translation */
	tls_id_route = routeid"""  
w.end()