# Check if (nestcolumn = nbnnestcol) AND (nestrow = nbnnestrow) AND (subductnum = nbnsubduct).  
#If different return <nestcolumn><nestrow><subductnum> e.g. "AB2" or "AB" */
#	ductCodeChanged(nestcolumn, nestrow, subductnum, nbnnestcol, nbnnestrow, nbnsubduct)

alternativeDuctSection = (duct) =>
	#concatenate nbn and non nbn 
	nbnStr = duct.nbnnestcol+duct.nbnnestrow+duct.subductnum
	tlsStr = duct.nestcolumn+duct.nestrow+duct.subductnum

	if nbnStr is not tlsStr
		return tlsStr
	else
	  return ""

w = new WebPage 'alternativeDuctSection',"Alternative Duct Section"

w.writeCode alternativeDuctSection.toString()

w.beginTable "NBN Profile","TLS Profile","Alternative Duct Section"

for k,duct of old_conduit[0..10]
	duct.nbnnestrow = "B"
	nbnStr = duct.nbnnestcol+duct.nbnnestrow+duct.subductnum
	tlsStr = duct.nestcolumn+duct.nestrow+duct.subductnum
	w.addToTable nbnStr, tlsStr, alternativeDuctSection duct
w.endTable()
w.end()