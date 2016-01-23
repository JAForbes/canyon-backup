unfit = (codedvalue) =>
  if 0 < codedvalue < 31
    return "Y"
  else
    return ""
  
w = new WebPage 'unfit',"Unfit"  
w.writeCode unfit.toString()
w.beginTable "Domain","Coded Value","Return"

for k,v of codedValues.oldpitscopestate
  w.addToTable k,v,unfit k

w.endTable()
w.end()