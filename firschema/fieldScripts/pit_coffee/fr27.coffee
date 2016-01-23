w = new WebPage 'fr27' , "FR27 - Insufficient Free capacity for Splice Enclosure"

fr27 = (codedvalue) =>
  if 0 < codedvalue < 10
    return "Y"
  else
    return ""

w.writeCode fr27.toString()

w.beginTable "Domain","Coded Value","Return"
for k,v of codedValues.oldpitscopestate
  
  w.addToTable k,v,fr27 k

w.endTable()
w.end()