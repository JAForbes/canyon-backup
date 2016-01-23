w = new WebPage 'fr19',"FR19 - Vehicle Splicing location not sufficiently close"

fr19 = (pit) =>
	return 'Y' if pit.scopestate is '30'
	''
w.writeCode fr19.toString()

w.beginTable "old_pit.scopestate","Description","Result"

for statecode,statedesc of codedValues.oldpitscopestate
	old_pit[0].scopestate = statecode
	w.addToTable statecode, statedesc, fr19 old_pit[0]

w.endTable()
w.end()