w = new WebPage('fr22','FR22 - In roadway and unable to withstand traffic')
w.writeCode """
            /* FR22 - In roadway and unable to withstand traffic
            If oldpitscopestate = 25
              return "Y"
            else
              return ""
            */
  	  """
w.end()