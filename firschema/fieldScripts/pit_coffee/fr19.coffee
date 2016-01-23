w = new WebPage 'fr19',"FR19 - Vehicle Splicing location not sufficiently close"

w.writeCode """	
				if oldpitscopestate == 31
				  return "Y"
				else
				  return ''
				"""
w.end()