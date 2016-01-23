w = new WebPage('fr22','FR22 - In roadway and unable to withstand traffic')
fr22 = (pit) =>
  return "Y" if pit.scopestate is "25"
  ""
w.writeCode fr22.toString()

old_pit[0].scopestate = "25"
w.beginTable "old_pit.scopestate","Description","Result"
w.addToTable old_pit[0].scopestate, codedValues.oldpitscopestate[old_pit[0].scopestate], fr22 old_pit[0]
w.end()