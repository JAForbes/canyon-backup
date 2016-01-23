asbestos = (pit) =>
  return "Y" if pit.asbestos is "Y"
  return ""

w = new WebPage("asbestos","Contains or may contain asbestos")

w.writeCode asbestos.toString()

w.beginTable "oldpit.asbestos","Result"

for k,v of codedValues.yesno
	p = old_pit[0]
	p.asbestos = k
	w.addToTable p.asbestos,asbestos p

w.endTable

w.end()