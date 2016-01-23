w = new WebPage "cables","Cables"
w.writeCode """
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
"""
w.end()