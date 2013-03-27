<HTML>
<HEAD>
	<link rel="stylesheet" href="style/style.css"/>
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" />
	<link rel="stylesheet" href="/resources/demos/style.css" />
	<script>
  	$(function() {
		$( "#PRESCRIBINGDATE" ).datepicker();
		$( "#TESTDATE" ).datepicker();
	});
	</script>
	<TITLE>Uploading module (insert new record)</TITLE>
</HEAD>

<BODY>

<%@ page import="java.sql.*,ca.awesome.*" %>
<%
	RecordController controller = new RecordController(
		getServletContext(), request, response, session);

	if (!controller.requireRadiologist()) {
		if (!controller.requireAdmin()) {
			return;
		}
	}

	if (controller.requestIsPost()) {
		if (controller.attemptInsertRecord()) {
			%><span class="success">new record has been inserted</span><%
		} else {
			%><span class="error">failed to insert record</span><%
		}
	}

%>
	<p><b>Uploading module (insert new record)</b></p><p><hr>

	<P><li>to insert a new radiology record :</P>
	<FORM NAME="insertRecord" ACTION="insertRecord.jsp" METHOD="post" >
	<fieldset><legend>radiology record information:</legend>
	<TABLE>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>record id:</I></B></TD><TD>
	<INPUT TYPE="text"NAME="RECORD_ID" VALUE="record_id"><BR></TD></TR>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>patient name:</I></B></TD><TD>
<!--	<select NAME=" <%= RecordController.PATIENT_FIELD%>">
		<% for (Record patient: controller.
<!--	<INPUT TYPE="text"NAME="PATIENT" VALUE="patient_name"><BR></TD></TR>
-->
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>doctor name:</I></B></TD><TD>

<!--	<INPUT TYPE="text"NAME="DOCTOR" VALUE="doctor_name"><BR></TD></TR>
-->
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>radiologist name:</I></B></TD><TD>
<!--	<INPUT TYPE="text"NAME="RADIOLOGIST" VALUE="radiologist name"><BR></TD></TR>
-->
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>test_type:</I></B></TD><TD>
	<INPUT TYPE="text"NAME="TESTTYPE" VALUE="test_type"><BR></TD></TR>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>prescribing date:</I></B></TD><TD>
	<INPUT TYPE="text" id="PRESCRIBINGDATE" NAME="PRESCRIBINGDATE" VALUE="Select a Date"><BR></TD></TR>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>test date:</I></B></TD><TD>
	<INPUT TYPE="text" id="TESTDATE" NAME="TESTDATE" VALUE="Select a Date"><BR></TD></TR>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>diagnosis:</I></B></TD><TD>
	<INPUT TYPE="text" size=50 NAME="DIAGNOSIS" VALUE="diagnosis"><BR></TD></TR>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>description:</I></B></TD><TD>
	<textarea rows = 10 cols = 65 name=DESCRIPTION></textarea>
	</TABLE>
	</fieldset>
	<INPUT TYPE="submit" NAME="InsertRecord" VALUE="submit new record">
	</FORM>





</BODY>
</HTML>

