w = new WebPage 'fr23',"FR23 - Not practical to install a Fibre Cable"

fr23 = (pit) =>
  return "Y" if pit.scopestate is "29"
  ""

w.writeCode fr23.toString()
old_pit[0].scopestate = "29"
w.beginTable "old_pit.scopestate","Description","Result"
w.addToTable old_pit[0].scopestate, codedValues.oldpitscopestate[old_pit[0].scopestate], fr23 old_pit[0]
w.end()