w = new WebPage 'mandrelmax','Maximum Mandrel Hauled (mm)'

mandrelMax = (duct) =>
  return mandrelmax if mandrelmax is not "0"
  return "N/A"

w.writeCode mandrelMax.toString()

w.end()