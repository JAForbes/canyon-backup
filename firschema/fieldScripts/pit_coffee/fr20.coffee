fr20 = (codedvalue) =>
  switch codedvalue
    when "12", "13", "16", "19"
      return "Y"
    else
      return ""

w = new WebPage 'fr20',"FR20 - Not accessible by hand digging"

w.beginTable "Domain","Coded Value","Return"
w.writeCode fr20.toString()

for k,v of codedValues.oldpitscopestate
  fr20()  
  w.addToTable k,v,fr20 k

w.endTable()
w.end()