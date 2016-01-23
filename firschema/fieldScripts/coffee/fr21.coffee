fr21 = (pit) =>
  switch pit.scopestate
    when "10","11", "15","16","17","18","19","20","25"
      return "Y"
    else
      return ""

w = new WebPage 'fr21',"FR21 - Does not provide appropriate mechanical protection"
w.writeCode fr21.toString()

w.beginTable "Domain","Coded Value","Return"
  
for k,v of codedValues.oldpitscopestate
	old_pit[0].scopestate = k
	w.addToTable k,v,fr21 old_pit[0]
  
w.endTable()
w.end()