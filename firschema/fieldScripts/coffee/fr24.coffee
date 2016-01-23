w = new WebPage 'fr24', "FR24 - Not structurally sound or not free of permanent water"

fr24 = (pit) =>
  return "Y" if pit.scopestate is "22"
  ""

w.writeCode fr24.toString()

old_pit[0].scopestate = "22"

w.beginTable "old_pit.scopestate","Description","Result"
w.addToTable old_pit[0].scopestate, codedValues.oldpitscopestate[old_pit[0].scopestate], fr24 old_pit[0]
w.end()