<HTML>
<HEAD>
	<link rel="stylesheet" href="style/style.css"/>
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" />
	<script>
 	$( "#from" ).datepicker({
		 defaultDate: "+1w",
		 changeMonth: true,
		 numberOfMonths: 3,
		 onClose: function( selectedDate ) {
		 $( "#to" ).datepicker( "option", "minDate", selectedDate );
		 }
		 });
	 $( "#to" ).datepicker({
		 defaultDate: "+1w",
		 changeMonth: true,
		 numberOfMonths: 3,
		 onClose: function( selectedDate ) {
		 $( "#from" ).datepicker( "option", "maxDate", selectedDate );
		 }
		 });
	 });
	</script>
	<TITLE>Report Generating Module</TITLE>
</HEAD>

<BODY>
	<p><b>Report Generating Module</b></p><p><hr>
	<FORM NAME="reportGen" ACTION="reportGen.jsp" METHOD="post" >
	<P><li>to get the list of all patients with a specified diagnosis for a given time period :</P>
	<fieldset><legend>Report Searching Information:</legend>
	<TABLE>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>Diagnosis:</I></B></TD><TD>
	<INPUT TYPE="text" size=50 NAME="DIAGNOSIS" VALUE="Diagnosis"><BR></TD></TR>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>Start Date:</I></B></TD><TD>
	<INPUT TYPE="text"  NAME="TIME_FROM" VALUE="Select a Date"><BR></TD></TR>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>End Date:</I></B></TD><TD>
	<INPUT TYPE="text" NAME="TIME_UNTIL" VALUE="Select a Date"><BR></TD></TR>
	</TABLE>
	</fieldset>
	<INPUT TYPE="submit" NAME="GenReport" VALUE="Generate Report">
	</FORM>
	
	<label for="from">From</label>
<input type="text" id="from" name="from" />
<label for="to">to</label>
<input type="text" id="to" name="to" />

</BODY>

</HTML>
		