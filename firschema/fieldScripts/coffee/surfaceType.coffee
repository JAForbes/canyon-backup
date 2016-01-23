mainArea = (pit) =>
  
  areas = 
    "Unspecified":0
    "Grass":(pit.bogoodturf)
    "Concrete":(pit.boconcrete)
    "Bitumen":(pit.bobituasph)
    "Paver":(pit.bobrickpav)

  largestNumber = Math.max (v for k,v of areas)...
  return (k for k,v of areas when v is largestNumber)[0]

surfaceType = (pit) =>    
  area = (mainArea pit)

  if area is "Concrete" or area is "Bitumen"
    if pit.inroadway is "Y"
      area + " roadway"
    else
      area + " footpath"
  else
    area

w = new WebPage 'surfaceType',"Surface Type"

w.writeCode surfaceType.toString()

w.writeWarning """
The following table uses randomly generated values.  Refresh to try more values.
"""
w.beginTable "pit.bogoodturf","pit.boconcrete","pit.bobituasph","pit.bobrickpav","Main Area","In Roadway","Return"
  
for k,pit of old_pit[0..10]
  for inroadway,desc of codedValues.yesno
    pit.bogoodturf = Math.floor Math.random() * 100
    pit.boconcrete = Math.floor Math.random() * 100
    pit.bobituasph = Math.floor Math.random() * 100
    pit.bobrickpav = Math.floor Math.random() * 100
    pit.inroadway = inroadway
    w.addToTable pit.bogoodturf, pit.boconcrete, pit.bobituasph,pit.bobrickpav, mainArea(pit),pit.inroadway,surfaceType pit

w.endTable()
w.end()