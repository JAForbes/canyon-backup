class window.WebPage
  constructor: (@divID,@heading) ->
    @html = []  
    document.querySelector(".span10").innerHTML += "<div id='#{@divID}'></div>"
    d = document.querySelector ".nav.nav-list"
    d.innerHTML += "<li><a href='##{@divID}'>#{@heading}</a></li></ul>"
    @html.push "<h2>#{@heading}</h2>"
    @html.push "<a href='./fieldScripts/coffee/#{@divID}.coffee'>Source Code Used To Generate Result</a>"

  end: () =>
    document.getElementById("#{@divID}").innerHTML = @html.join("")

  #parse a multi line to a <pre><code> string tag 

  writeWarning: (message) =>
    @html.push """
    <div class="alert">
      <button type="button" class="close" data-dismiss="alert">&times;</button>
      <strong>Warning!</strong> """+message+"""
    </div>
    """

  writeHtml: (html) =>
    @html.push html

  writeCode: (code) =>
    @html.push "<pre><code>#{code}</code></pre>"

  beginTable: (headings...) =>
    @html.push "<table class='table table-striped' width='200px'>"
    table = "<tr>"
    for heading in headings
    	table+="<th>#{heading}</th>"
    table += "</tr>"
    @html.push table

  addToTable: (cells...) =>
    table = "<tr>"
    for cell in cells
    	table+="<td>#{cell}</td>"
    table +="</tr>"
    @html.push table

  endTable: () =>
    @html.push "</table>"
