w = new WebPage 'otherDamage',"Other relevant physical damage"

otherDamage = (damagecolr,damagelid,damagepit) =>
  elements = []
  if damagecolr is "Y"
    elements.push "Collar"
  if damagelid is "Y"
    elements.push "Lid"
  if damagepit is "Y"
    elements.push "Pit Body"

  switch elements.length
    when 1
      return "#{elements[0]} damaged"
    when 2
      return "#{elements[0]} and #{elements[1]} damaged"
    when 3
      return "#{elements[0]}, #{elements[1]} and #{elements[2]} damaged"
    else
      return ""  

w.writeCode otherDamage.toString()
  
yMatrix = [
  ["","",""]
  ["Y","",""]
  ["","Y",""]
  ["","","Y"]
  ["Y","Y",""]
  ["","Y","Y"]
  ["Y","","Y"]
  ["Y","Y","Y"]
]

w.beginTable "Collar","Lid","Pit","Comment"

for k, row of yMatrix
  comment = otherDamage row...

  if comment.length > 0
    row.push comment
    w.addToTable row...

w.endTable()  
w.end()