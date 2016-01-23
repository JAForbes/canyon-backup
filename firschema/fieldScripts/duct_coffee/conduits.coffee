w = new WebPage "conduits","Conduits"
w.writeHtml """
<div class='alert'>
  <button type='button' class='close' data-dismiss='alert'>&times;</button>
  <strong>Warning!</strong> Assumed function <code>countConduits()</code>
</div>
"""

w.writeCode """
/* Count how many conduits share a routeid */
countConduits(routeid)
"""
w.end()