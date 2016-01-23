w = new WebPage 'fr23',"FR23 - Not practical to install a Fibre Cable"

w.writeCode """
/* FR23 - Not practical to install a Fibre Cable */
If oldpitscopestate == 29
  return "Y"
else
  return ""
  """
w.end()