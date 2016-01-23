w = new WebPage 'pitNameChanged',"Actual existing Pit size and type different from Planning information"
w.writeCode """
  		 	if tlspitname != actpitname 
  		 	  return "Y"
  		 	else
  		 	  return ""
  				  """
w.end()