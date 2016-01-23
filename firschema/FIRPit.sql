/* Note this is Pseudo SQL */
/*	John Forbes
	Start:	201305161243
	Finish:	201305161920
*/

/* The below does not consider cases with null values*/

/* Fields that do not yet exist in schema:
	owner
	notperplan
*/

Select Where projectid = userRequestedProjectID AND owner = 0 AND scopestate > 0

/* FIR Field Transformations*/
	/* system_id not provided in NDD GML, default value to 0 on FIR */
	system_id = 0
	
	/* One to one translation */
	tls_id	=	id
	
	/* See Functions Section */
	type	=	getType(tlspitname)
	spec_id	=	getspec_id(tlspitname)
	Size	=	getSize(tlspitname)
	
	/* Not Applicable for Transits.  Default value to 0 on FIR */
	mpt	=	0
	ajl	=	0
	ljl	=	0
	djl	=	0
	
	/* See Functions Section */
	enclosure_count	=	countFibreNodes(jointids)
	
	/* No need to populate */
	breakout	=	""
	remediate	=	""
	remediate_to = ""
	OHS_pit	= ""

	/* See Functions Section */	
	Not Located	=	checkNotLocated(scopestate)
	
	/* One to one translation */
	Location not as per Planning Information	=	notperplan
	
	/* See Functions Section */	
	Actual existing Pit size and type different from Planning information	=	pitNameChanged(tlspitname, actpitname)
	
	/* One to one translation */
	Contains or may contain asbestos 	=	asbestos
	
	/* See Functions Section */
	Unfit	=	checkUnfit(scopestate)
	FR19 - Vehicle Splicing location not sufficiently close	=	checkFR19(scopestate)
	FR20 - Not accessible by hand digging	=	checkFR20(scopestate)
	FR21 - Does not provide appropriate mechanical protection	=	checkFR21(scopestate)
	FR22 - In roadway and unable to withstand traffic	=	checkFR22(scopestate)
	FR23 - Not practical to install a Fibre Cable	=	checkFR23(scopestate)
	FR24 - Not structurally sound or not free of permanent water	=	checkFR24(scopestate)
	FR25 - Foreign matter obstructing Duct Section access point	=	checkFR25(scopestate)
	FR26 - Occupational, Health or Safety Risk	=	checkFR26(scopestate)
	FR27 - Insufficient Free capacity for Splice Enclosure	=	checkFR27(scopestate)
	Remediation Required	=	checkRemediation(scopestate)
	Conduit Breakout required	=	checkForConnectingNewRoute(id)
	Surface Type	=	chooseSurface(bogoodturf, boconcrete, bobituasph, bobrickpav, inroadway)
	General Comments	=	selectComment(stdcomment, fircomment)
	
	/* One to one translation */
	Photograph taken	=	phototaken
	
	/* Not Applicable for Transits. */
	FDA	=	""
	
	/* See Functions Section */
	Other relevant physical visible damage	=	checkDamage(damagecolr, damagelid, damagepit)

/*	Functions	*/


	getType(tlspitname)	/*
		If (tlspitname = 32 OR If tlspitname = 33 OR tlspitname = 40 OR If tlspitname = 41 OR tlspitname = 42 OR If tlspitname = 43) Then 
			Type = Manhole
		Else
			Type = Pit
		*/
		/* See pitname.code to FIR table */
	
	getSpec_id(tlspitname)	/* Use pitname.code to FIR table */
	
	getSize(tlspitname)	/* Use pitname.code to FIR table */
	
	countFibreNodes(jointids)	/* Return Count of unique joint IDs */
	
	checkNotLocated(scopestate)	/*
		If scopestate = 24 i.e. "Other - Unable to Locate" Then
			return "Y"
		else
			return ""
		*/

	pitNameChanged(tlspitname, actpitname)	/*
		If tlspitname <> actpitname Then
			return value from FIR."Actual existing Pit size and type different from Planning information" column in the pitname.code to FIR table
		else
			return ""
		*/

	checkUnfit(scopestate)	/*
		If scopestate > 0 AND scopestate < 31 Then
			return "Y"
		else
			return ""
		*/
		
	checkFR19(scopestate)	/* FR19 - Vehicle Splicing location not sufficiently close
		If scopestate = 30 Then
			return "Y"
		else
			return ""
		*/
		
	checkFR20(scopestate)	/* FR20 - Not accessible by hand digging
		If scopestate = 12 OR scopestate = 13 OR scopestate = 16 OR scopestate = 19 Then
			return "Y"
		else
			return ""
		*/
		
	checkFR21(scopestate)	/* FR21 - Does not provide appropriate mechanical protection
		If (scopestate = 10 OR scopestate =  11 OR scopestate =  15 OR scopestate =  16 OR scopestate =  17 OR scopestate =  18 OR scopestate =  19 OR scopestate =  20 OR scopestate =  25) Then
			return "Y"
		else
			return ""
		*/
		
	checkFR22(scopestate)	/* FR22 - In roadway and unable to withstand traffic
		If scopestate = 25 Then
			return "Y"
		else
			return ""
		*/

	checkFR23(scopestate)	/* FR23 - Not practical to install a Fibre Cable
		If scopestate = 29 Then
			return "Y"
		else
			return ""
		*/
	checkFR24(scopestate)	/* FR24 - Not structurally sound or not free of permanent water
		If scopestate = 22 Then
			return "Y"
		else
			return ""
		*/
		
	checkFR25(scopestate)	/* FR25 - Foreign matter obstructing Duct Section access point
		If scopestate = 23 Then
			return "Y"
		else
			return
		*/
		
	checkFR26(scopestate)	/* FR26 - Occupational, Health or Safety Risk
		If scopestate = 21 Then
			return "Y"
		else
			return
		*/
	checkFR27(scopestate)	/* FR27 - Insufficient Free capacity for Splice Enclosure
		If scopestate > 0 AND scopestate < 10  Then
			return "Y"
		else
			return
		*/
		
	checkRemediation(scopestate)	/* Remediation Required
		If scopestate > 0 AND scopestate < 27 Then
			return "Y"
		else
			return
		*/

	checkForConnectingNewRoute(id)	/*
		Search for id in newundergroundroute table to check how many occurences there are in either start or end nodes of new routes.
		*/

	chooseSurface(bogoodturf, boconcrete, bobituasph, bobrickpav, inroadway)	/* This works by returning the value which corresponds to the largest area in our system.
		mainArea = findLargestArea(bogoodturf, boconcrete, bobituasph, bobrickpav)
		If mainArea = "zero" Then
			return "Unspecified"
		Else
			If mainArea = "bogoodturf" Then
				return "Grass"
			Else
				If mainArea = "boconcrete" Then
					if inroadway = "Y" Then
						return "Concrete driveway"
					else
						return "Concrete footpath"
					end if
				else
					If mainArea = "bobituasph" Then
						if inroadway = "Y" Then
							return "Bitumen roadway"
						else
							return "Bitumen footpath"
						End If
					else
						if mainArea = "bobrickpav" then
							return "Paver"
						End If
					End If
				End If
			End If
		End If
	*/
	
	findLargestArea(bogoodturf, boconcrete, bobituasph, bobrickpav)	/* returns name of input field with largest value as string, or if all areas are zero it returns "zero"	*/
	
	selectComment(stdcomment, fircomment)	/* If stdcomment = 127 Then return fircomment else return stdcomment text*/
	
	checkDamage(damagecolr, damagelid, damagepit) /*
		autoComment = ""
		commentStarted = 0
		If damagecolr = "Y" Then
			autocomment = "Collar damaged."
			commentStarted = 1
		End If
		If damagelid = "Y" Then
			if commentPieces > 0 Then
				autocomment = autocomment + "  Lid damaged."
			else
				autocomment = "Lid Damaged."
				commentStarted = 1
			End If
		End If
		If damagepit = "Y" Then
			if commentPieces > 0 Then
				autocomment = autocomment + "  Pit body damaged."
			else
				autocomment = "Pit body damaged."
				commentStarted = 1
			End If
		End If
		return autocomment
		*/