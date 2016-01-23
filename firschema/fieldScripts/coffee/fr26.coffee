w = new WebPage 'fr26' , "FR26 - Occupational, Health or Safety Risk"

fr26 = (pit) =>
  return "Y" if pit.scopestate is "21"
  ""

w.writeCode fr26.toString()
old_pit[0].scopestate = "26"
w.beginTable "old_pit.scopestate","Description","Result"
w.addToTable old_pit[0].scopestate, codedValues.oldpitscopestate[old_pit[0].scopestate], fr26 old_pit[0]
w.end()