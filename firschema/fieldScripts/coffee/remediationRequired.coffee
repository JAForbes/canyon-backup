w = new WebPage 'remediationRequired',"Remediation Required"

remediationRequired = (pit) =>
  if 0<pit.scopestate<27
    return "Y"
  else
    return ""

w.writeCode remediationRequired.toString()

w.beginTable "Domain","Coded Value","Return"

for k,v of codedValues.oldpitscopestate
	old_pit[0].scopestate = k
	w.addToTable k,v,remediationRequired old_pit[0]
  
w.endTable()

w.end()