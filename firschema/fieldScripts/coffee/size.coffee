w = new WebPage("size","Size")

getSize = (pit) ->
  description = codedValues.pitname[pit.tlspitname]
  digit = description.match(/\d/)?[0]
  switch description
    when "Vic D"
      return "VD"
    when "X - Other"
      return "X"
    when "0"
      return "O"
  if description.match(/MH/)?
  	return "MH"
  if digit?
    return digit
  return description

w.writeCode getSize.toString()

w.beginTable "Telstra Pit Name","Description","Size"

for k,v of codedValues.pitname
  old_pit[0].tlspitname = k
  w.addToTable k,v, getSize old_pit[0]

w.endTable()
w.end()