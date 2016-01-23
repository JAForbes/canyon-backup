fr20 = (pit) =>
  switch pit.scopestate
    when "12", "13", "16", "19"
      return "Y"
    else
      return ""

w = new WebPage 'fr20',"FR20 - Not accessible by hand digging"

w.beginTable "Domain","Coded Value","Return"
w.writeCode fr20.toString()

for k,v of codedValues.oldpitscopestate
	old_pit[0].scopestate = k
	w.addToTable k,v,fr20 old_pit[0]

w.endTable()
w.end()