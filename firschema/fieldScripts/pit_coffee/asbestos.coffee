if document?
  w = new WebPage("asbestos","Contains or may contain asbestos")
  
  w.writeCode """/* One to one translation */
  Contains or may contain asbestos = asbestos"""
  
  w.end()