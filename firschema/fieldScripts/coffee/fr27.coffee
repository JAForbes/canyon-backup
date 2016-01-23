w = new WebPage 'fr27' , "FR27 - Insufficient Free capacity for Splice Enclosure"

fr27 = (pit) =>
  if 0 < pit.scopestate < 10
    return "Y"
  else
    return ""

w.writeCode fr27.toString()

w.beginTable "Domain","Coded Value","Return"
for k,v of codedValues.oldpitscopestate
  old_pit[0].scopestate = k
  w.addToTable k,v,fr27 old_pit[0]

w.endTable()
w.end()