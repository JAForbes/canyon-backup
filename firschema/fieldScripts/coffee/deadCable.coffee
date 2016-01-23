deadCable = (duct) =>
  duct.deadCable if duct.deadCable is "Y"
  ""

w = new WebPage 'deadCable','Insitu Dead Cable identified'
w.writeCode deadCable.toString()
w.end()