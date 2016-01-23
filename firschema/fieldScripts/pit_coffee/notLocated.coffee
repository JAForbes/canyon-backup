notLocated = (v) ->
  if v.match "Other - Unable to Locate"
    return "Y"
  else
    return ""

w = new WebPage 'notLocated' , 'Not Located'

w.writeCode notLocated.toString()
w.beginTable 'Coded Value','Description','Return'

for k,v of codedValues.oldpitscopestate
  w.addToTable k,v,notLocated v

w.endTable()
w.end()