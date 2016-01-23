#All possible descriptions in database schema
descriptions = ["J1","J2","J3","J4","J5","J8","J9"
				"H1","H2","H4","H5","H3","H8","H9"
				"P1","P2","P3","P4","P5","P8","P9"
				"1","2","3","4","6","7","8"
				"C6","C8","C9"
				"Vic D"
				"MH - Footway","MH - Roadway"
				"A","B","C","D","0"
				"X - Other",]

#associated longer descriptions for particular codes
pitCodes = {"J":"Injection Moulded","H":"Hand Moulded","P":"Thermoplastic","PC":"Precast"}

#used to output to webpage
webPage = []

if document?
  d = document.querySelector ".nav.nav-list"
  d.innerHTML = d.innerHTML.replace "</ul>","" + "<li><a href='#specID'>specID</a></li></ul>"
	webPage.push("<h2>Specification ID</h2>")
	webPage.push("<a href='./specID.coffee'>Source Code Used To Generate Result</a>")
	webPage.push("<table class='table table-striped' width='200px'>")
	webPage.push("<tr><th>Description</th><th>Sentence</th></tr>")

#generate the correct specID for each possible description
for description in descriptions

  #pit size is the first digit found in the string
  pitSize = description[description.search /\d/] #capture the first digit in the string

  #pitCode is the first character of the string description
  pitCode = description[0]

  ###EDGE CASES###

  #if there is no pit size and the code is C
  if pitSize? and pitCode is "C"
  	#Precast
  	pitCode = "PC"

  #if a Victiorian Pit
  if pitCode is "V"
  	#D Pit
  	pitSize = "D"

  #0 Pit
  if pitCode is "0"
  	#Show it as an O pit
  	pitCode = "O"

  #Long description for shorter code ie H = Hand Moulded
  longForm = pitCodes[pitCode]

  switch pitCode
    when "H", "J", "P", "PC" 
      sentence = "Pit #{pitSize}, #{pitCode} (#{longForm})" #e.g. Pit 4, P (Thermoplastic)
    when "V"
      sentence = "Pit D, H (Hand Moulded - Vic)"
    when "M"
      sentence = description.replace "MH", "Manhole"
    when "X"
      sentence = "Other"
    else
      sentence = "Pit #{pitCode}, H (Hand Moulded)"

  if document?

    webPage.push "<tr><td>#{description}</td><td>#{sentence}</td></tr>"
  if root?
    console.log("#{description}\t#{sentence}")

if document?
  webPage.push "</table>"
  document.getElementById('specID').innerHTML = webPage.join("")