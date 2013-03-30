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
			return;
	}

	if (controller.requestIsPost()) {
		if (controller.attemptInsertRecord()) {
			%><span class="success">new record has been inserted 
			<br><TABLE border="1"><TR VALIGN=TOP ALIGN=LEFT>
			<TD>record id</TD><TD>patient name</TD><TD>doctor name</TD>
			<TD>radiologist name</TD><TD>test type</TD><TD>prescribing date</TD>
			<TD>test date</TD><TD>diagnosis</TD></TR>
			<TR VALIGN=TOP ALIGN=LEFT>
			<TD><%= controller.record_id %></TD>
			<TD><%= controller.patientName %></TD>
			<TD><%= controller.doctorName %></TD>
			<TD><%= controller.radiologistName %></TD>
			<TD><%= controller.testType %></TD>
			<TD><%= controller.prescribing %></TD>
			<TD><%= controller.testDate %></TD>
			<TD><%= controller.diagnosis %></TD></TR></TABLE>
			</span><%
		} else {
			%><span class="error">failed to insert record
			<br><TABLE border="1"><TR VALIGN=TOP ALIGN=LEFT>
			<TD>record id</TD><TD>patient name</TD><TD>doctor name</TD>
			<TD>radiologist name</TD><TD>test type</TD><TD>prescribing date</TD>
			<TD>test date</TD><TD>diagnosis</TD></TR>
			<TR VALIGN=TOP ALIGN=LEFT>
			<TD><%= controller.record_id %></TD>
			<TD><%= controller.patientName %></TD>
			<TD><%= controller.doctorName %></TD>
			<TD><%= controller.radiologistName %></TD>
			<TD><%= controller.testType %></TD>
			<TD><%= controller.prescribing %></TD>
			<TD><%= controller.testDate %></TD>
			<TD><%= controller.diagnosis %></TD></TR></TABLE>
			</span><%
		}
	}

	controller.getInsertRecord();

%>
	<p><b>Uploading module (insert new record)</b></p><p><hr>

	<P><li>to insert a new radiology record :</P>
	<FORM NAME="insertRecord" ACTION="insertRecord.jsp" METHOD="post" >
	<fieldset><legend>radiology record information:</legend>
	<TABLE>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>patient name:</I></B></TD><TD>
	<select NAME="PATIENT">
		<% for (User patient: controller.patients) { %>
			<option value="<%= patient.getUserName() %>">
				<%= patient.getUserName() %>
			</option>
		<% } %>
	</select><BR></TD></TR>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>doctor name:</I></B></TD><TD>
	<select NAME="DOCTOR">
		<% for (User doctor: controller.doctors) { %>
			<option value="<%= doctor.getUserName() %>">
				<%= doctor.getUserName() %>
			</option>
		<% } %>
	</select><BR></TD></TR>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>test type:</I></B></TD><TD>
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
	<ul><hr><li><a href="uploadToRecord.jsp">upload image to record</a></li>
	<li><a href="logout.jsp">logout</a></li></ul>





</BODY>
</HTML>

