w = new WebPage 'remediationRequired',"Remediation Required"

remediationRequired = (scopestate) =>
  if 0<scopestate<27
    return "Y"
  else
    return ""

w.writeCode remediationRequired.toString()

w.beginTable "Domain","Coded Value","Return"

for k,v of codedValues.oldpitscopestate
  w.addToTable k,v,remediationRequired k
  
w.endTable()

w.end()