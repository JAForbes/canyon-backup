#used to output to webpage
webPage = []

if false
  mainSection = document.querySelector(".span10")
  mainSection.innerHTML += "<div id='codedValues'></div>"
  d = document.querySelector ".nav.nav-list"
  d.innerHTML += "<li><a href='#codedValues'>Coded Values</a></li></ul>"
  webPage.push "<h2>Coded Values</h2>"
  webPage.push "<a href='./fieldScripts/codedValuesOutput.coffee'>Source Code Used To Generate Result</a>"

  webPage.push("<table class='table table-striped'>")
  webPage.push("<tr><th>Domain</th><th>Coded Value</th><th>Description</th></tr>")
  	
  for key, obj of codedValues

  	for subKey, subObj of obj
      webPage.push "<tr><td>#{key}</td><td>#{subObj}</td><td>#{subKey}</td></tr>"

  webPage.push "</table>"

  document.getElementById('codedValues').innerHTML = webPage.join("")