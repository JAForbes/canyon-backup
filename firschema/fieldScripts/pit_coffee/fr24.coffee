w = new WebPage 'fr24', "FR24 - Not structurally sound or not free of permanent water"

w.writeCode """
/* FR24 - Not structurally sound or not free of permanent water*/

if oldpitscopestate == 22
  return "Y"
else
  return ""
"""
w.end()