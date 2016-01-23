/* Note this is Pseudo SQL */

/*	John Forbes
	Start:	201305161119
	Finish:	201305161243 
*/
/* The below does not consider cases with null values*/
/* Fields that do not yet exist in schema:
	nbnnestcol
	nbnnestrow
	nbnsubduct
	nbnmat
	nbndiamtr
	notperplan
	deadCable
	otherdamage
*/
/* This is the general selection to determine which records enter the FIR 
	userRequestedProjectID is the ID of the site for which the user wants to produce an FIR 
	owner = 0 selects only Telstra Conduits
	scopestate = 2 selects Design Altered Ducts
	scopestate = 3 selects Remediation Ducts
	scopestate = 5 selects Fit Ducts
	scopestate = 6 not yet implemented in Schema, this code represents where the duct could not be found.
*/
Select Where projectid = userRequestedProjectID AND owner = 0 AND (scopestate = 2 OR scopestate = 3 OR scopestate = 5, OR scopestate = 6)
/* FIR Field Transformations*/
	/* system_id not provided in NDD GML, default value to 0 on FIR */
	system_id = 0
	
	/* One to one translation */
	tls_id_route = routeid	
	tls_id_conduit = conduitid
	start_node_tls_id = startnode
	end_node_tls_id = endnode
	
	/* Only one length provided in NDD GML */
	calculated_length = nbnlength
	measured_length = nbnlength
	
	/* See Functions Section */
	conduits = countConduits(routeid)
	conduit_material_and_diameter = makeNestProfile(routeid, nbnnestcol, nbnnestrow, nbnsubduct, nestcolumn, nestrow, subductnum, material, nbndiamtr, diameter, fill)
	NBN_reserved_duct = makeDuctCode(nbnnestcol, nbnnestrow, nbnsubduct)
	material = makeFIRDuctMaterial(nbnmat, material, nbndiamtr, diameter)
	
	/* Not Applicable for Transits.  Default value to 0 on FIR */
	sds_1f = 0
	mss_12f = 0
	lss_72f = 0
	lss_144f = 0
	lss_288f = 0
	hsl_288f = 0
	hsl_432f = 0
	hsl_576f = 0
	hsd_72f = 0
	dss_72f = 0
	dss_144f = 0
	dss_288f = 0
	dss_432f = 0
	dss_576f = 0
	
	/* See Functions Section */
	cable_count = countCables(cableids)
	Not Located = calcNotLocated(scopestate)
	
	/* One to one translation */
	Location not as per Planning Information (Y/N) = notperplan
	
	/* See Functions Section */
	Duct size not as per Planning Information (select size from list) = ductSizeChanged(nbndiamtr, diameter)
	Duct make not as per Planning Information = ductMakeChanged(nbnmat, material)
	Alternative Duct Section (Telstra ID ie BB, CA) = ductCodeChanged(nestcolumn, nestrow, subductnum, nbnnestcol, nbnnestrow, nbnsubduct)
	
	/* One to one translation */
	Actual measured length (m) = actlength
	
	/* See Functions Section */
	Unfit = calcUnfit(scopestate)
	
	/*Not Implemented */
	FR1
	
	/* One to one translation */
	FR2 - Not continuous = fr02
	
	/* See Functions Section */
	FR3 - Length greater than 250m = greaterThan250(actlength)

	/*Not Implemented */
	FR4
	
	/* One to one translation */
	FR5 - Damaged resulting in reduced capacity = fr05
	FR6 - Permanently flooded = fr06
	FR7 - Contains obstruction, debris or internal damage = fr07
	FR8 - Cover < 300mm = fr08
	FR9 - Occupational, Health or Safety Risk = fr09
	FR10 - Does not remain underground at all points = fr10
	
	/*Not Implemented */
	FR11
	FR12
	FR13

	/* One to one translation */
	FR14 - Severed = fr14
	FR15 - Failed pull through test = fr15
	FR16 - Insufficient capacity which is Free = fr16
	
	/*Not Implemented */
	FR17
	FR18

	/* One to one translation */
	A end block distance (m) = blockenda
	B end block distance (m) = blockendb
	Maximum Mandrel Hauled (mm) = mandrelmax
	Surface Type at Blockage Location = blocksurf
	Insitu Dead Cable identified = deadCable

	/* See Functions Section */
	General Comments = selectComment(stdcomment, fircomment)
	
	/* One to one translation */
	Photograph Taken = phototaken
	
	/* Not applicable for Transit Link */
	FDA = ""
	
	/* One to one translation */
	Other relevant physical visible damage = otherdamage

/* Functions */
	/* Count unique cable ids listed in cable ID summary */
	countCables(cableids)
	
	/* Need to find all conduits that share that routeid */
	countConduits(routeid)
	
	/* Find all conduits with same route id & make nest profile in form: <nestColumn><nestRow><subDuctNum>:<material><diameter>:<fill>%,<...> e.g. "CB1:P100:0.0%,AB:P100:18.0%,AC:P100:6.0%" */
	makeNestProfile(routeid, nbnnestcol, nbnnestrow, nbnsubduct, nestcolumn, nestrow, subductnum, material, nbndiamtr, diameter, fill)
	
	/* Build Duct code in the form <nbnnestcol><nbnnestrow><nbnsubduct>  e.g. "AB1" or "AB" */
	makeDuctCode(nbnnestcol, nbnnestrow, nbnsubduct)
	
	/* Create Duct Material in the form <nbnmat|material><nbndiamtr|diameter>*/
	makeFIRDuctMaterial(nbnmat, material, nbndiamtr, diameter)
	
	/* If scopestate = 6 Then return "Y" */
	calcNotLocated(scopestate)
	
	/* Check if original diameter is different to diameter updated by Scoper.  If different return <diameter>. */	
	ductSizeChanged(nbndiamtr, diameter)
	
	/* Check if original duct material is different to material updated by Scoper.  If different return value from FIR dictionary that corresponds with value in <material>. */
	ductMakeChanged(nbnmat, material)
	
	/* Check if (nestcolumn = nbnnestcol) AND (nestrow = nbnnestrow) AND (subductnum = nbnsubduct).  If different return <nestcolumn><nestrow><subductnum> e.g. "AB2" or "AB" */
	ductCodeChanged(nestcolumn, nestrow, subductnum, nbnnestcol, nbnnestrow, nbnsubduct)

	/* If scopestate = 3 Then return "Y" */
	calcUnfit(scopestate)
	
	/* If actlength > 250 Then return "Y" */
	greaterThan250(actlength)
	
	/* If stdcomment = 127 Then return fircomment else return stdcomment text*/
	selectComment(stdcomment, fircomment)