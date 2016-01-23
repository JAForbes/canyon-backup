if document?
  w = new WebPage('end_node',"End Node")

  w.writeCode """/* One to one translation */
	end_node_tls_id = endnode"""
w.end()