if document?
  w = new WebPage("tls_id","Telstra ID")
  w.writeCode """
    /* One to one translation */
    tls_id  = id"""
  w.end()