type = (description) =>
	if v.match /MH/
		return "Manhole"
	else
		return "Pit"

w = new WebPage('type',"Type")

w.writeCode type.toString()

w.beginTable("Domain","Coded Value","Type")

for k,v of codedValues.pitname
	w.addToTable k,v,type v

w.endTable()
w.end()