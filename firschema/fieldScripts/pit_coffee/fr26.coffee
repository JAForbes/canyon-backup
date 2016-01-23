w = new WebPage 'fr26' , "FR26 - Occupational, Health or Safety Risk"

w.writeCode """
/* FR26 - Occupational, Health or Safety Risk */
if scopestate == 21
  return "Y"
else
  return ""
"""
w.end()