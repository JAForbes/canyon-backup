w = new WebPage 'fr25',"FR25 - Foreign matter obstructing Duct Section access point"

fr25 = (pit) =>
  return "Y" if pit.scopestate is "23"
  ""

w.writeCode fr25.toString()

old_pit[0].scopestate = "23"

w.beginTable "old_pit.scopestate","Description","Result"
w.addToTable old_pit[0].scopestate, codedValues.oldpitscopestate[old_pit[0].scopestate], fr25 old_pit[0]

w.end()