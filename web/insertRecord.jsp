<HTML>
<HEAD>
	<link rel="stylesheet" href="style/style.css"/>
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" />
	<link rel="stylesheet" href="/resources/demos/style.css" />
	<script>
  	$(function() {
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
	<TITLE>Uploading module (insert new record)</TITLE>
</HEAD>

<BODY>
	<p><b>Report Generating Module (insert new record)</b></p><p><hr>

	<P><li>to insert a new radiology record :</P>
	<FORM NAME="insertRecord" ACTION="manage.jsp" METHOD="post" >
	<fieldset><legend>radiology record information:</legend>
	<TABLE>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>record id:</I></B></TD><TD>
	<INPUT TYPE="text"NAME="RECORD_ID" VALUE="record_id"><BR></TD></TR>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>patient name:</I></B></TD><TD>
	<INPUT TYPE="text"NAME="PATIENT" VALUE="patient_name"><BR></TD></TR>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>doctor name:</I></B></TD><TD>
	<INPUT TYPE="text"NAME="DOCTOR" VALUE="doctor_name"><BR></TD></TR>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>radiologist name:</I></B></TD><TD>
	<INPUT TYPE="text"NAME="RADIOLOGIST" VALUE="radiologist name"><BR></TD></TR>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>test_type:</I></B></TD><TD>
	<INPUT TYPE="text"NAME="TESTTYPE" VALUE="test_type"><BR></TD></TR>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>prescribing date:</I></B></TD><TD>
	<INPUT TYPE="text"NAME="PRESCRIBINGDATE" VALUE="Select a Date"><BR></TD></TR>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>test date:</I></B></TD><TD>
	<INPUT TYPE="text"NAME="TESTDATE" VALUE="Select a Date"><BR></TD></TR>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>diagnosis:</I></B></TD><TD>
	<INPUT TYPE="text" size=50 NAME="DIAGNOSIS" VALUE="diagnosis"><BR></TD></TR>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>description:</I></B></TD><TD>
	<textarea rows = 10 cols = 65 name=DESCRIPTION></textarea>
	</TABLE>
	</fieldset>
	<INPUT TYPE="submit" NAME="InsertRecord" VALUE="submit new record">
	</FORM>


<%@ page import="java.sql.*,ca.awesome.*" %>
<%
	RecordController controller = new RecordController(
		getServletContext(), request, response, session);

	if (!controller.requireRadiologist()) {
		return;
	}

	if (controller.requestIsPost()) {
		if (controller.attemptInsertRecord()) {
			%><span class="success">new record has been inserted</span><%
		} else {
			%><span class="error">failed to insert record</span><%
		}
	}

%>


</BODY>
</HTML>

