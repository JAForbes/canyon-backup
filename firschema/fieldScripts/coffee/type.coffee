type = (pit) =>
	description = codedValues.pitname[pit.tlspitname]
	if v.match /MH/
		return "Manhole"
	else
		return "Pit"

w = new WebPage('type',"Type")

w.writeCode type.toString()

w.beginTable("Domain","Coded Value","Type")

for k,v of codedValues.pitname
	old_pit[0].tlspitname = v
	w.addToTable k,v,type old_pit[0]

w.endTable()
w.end()