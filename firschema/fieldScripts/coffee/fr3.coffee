w = new WebPage 'fr3',"FR3"

fr3 = (duct) =>
	['Y' if duct.actlength > 250]+''

w.writeCode fr3

w.beginTable "Actual Length","FR3"

for k,duct of old_conduit[0..10]
	duct.actlength = Math.floor Math.random() * 150
	duct.actlength += 250 if k%4 is 0
	w.addToTable duct.actlength, fr3 duct

w.endTable()

w.end()