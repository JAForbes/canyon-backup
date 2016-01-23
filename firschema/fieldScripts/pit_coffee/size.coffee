w = new WebPage("size","Size")

getSize = (v) ->
  digit = v.match(/\d/)?[0]
  switch v
    when "Vic D"
      return "VD"
    when "X - Other"
      return "X"
    when "0"
      return "O"
  if v.match(/MH/)?
  	return "MH"
  if digit?
    return digit
  return v

w.writeCode getSize.toString()

w.beginTable "Pit Name","Size"

for k,v of codedValues.pitname
  w.addToTable v, getSize v

w.endTable()
w.end()