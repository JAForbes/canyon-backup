w = new WebPage 'fr25',"FR25 - Foreign matter obstructing Duct Section access point"

w.writeCode """
"FR25 - Foreign matter obstructing Duct Section access point"
If oldpitscopestate == 23
  return "Y"
else
  return ""
"""
w.end()