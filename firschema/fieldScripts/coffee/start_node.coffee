if document?
  w = new WebPage('start_node',"Start Node")

  w.writeCode """/* One to one translation */
	start_node_tls_id = startnode"""
w.end()