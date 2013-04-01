<HTML>
<HEAD>
	<TITLE>Data analysis module</TITLE>
</HEAD>

<BODY>
	<p><b>Data analysis module</b></p><p><hr>
	<FORM NAME="analysis" ACTION="analysisInput.jsp" METHOD="post" >
	<P><li>to generate the OLAB report on number of radiology record images:</P>
	<fieldset><legend>select one or more:</legend>
	<TABLE>
	<TR VALIGN=TOP ALIGN=LEFT>
	<TD><input type="checkbox" name="PATIENT_BOX" value="PATIENT"><B>for each patient</B></TD><TR>
	<TR VALIGN=TOP ALIGN=LEFT>
	<TD><input type="checkbox" name="TYPE_BOX" value="TESTTYPE"><B>for each test type</B></TD><TR>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B> period of time:</B></TD><TD>
	<select name="PERIOD">
	<option value="NONE" selected>none</option>
	<option value="YEARLY">yearly</option>
	<option value="MONTHLY">monthly</option>
	<option value="WEEKLY">weekly</option>
	</select></TD></TR>
	</TABLE>
	</fieldset>
	<INPUT TYPE="submit" NAME="getOLAB" VALUE="generate">
	</FORM>

<%@ page import="java.sql.*,ca.awesome.*" %>
<%
	OLAPController controller = new OLAPController(
		getServletContext(), request, response, session);

	if (!controller.requireAdmin()) {
			return;
	}

	if (controller.requestIsPost()) {
		controller.getInput();
%>
<TABLE border="1">
<TR VALIGN=TOP ALIGN=LEFT>
	<TD><B>Year</B></TD>
	<TD><B>Month</B></TD>
	<TD><B>Week</B></TD>
	<TD><B>Patient</B></TD>
	<TD><B>test type</B></TD>
	<TD><B>Image count</B></TD></TR>
<%	int index = 1; 	
	for (String temp : controller.attemptGetOLAP()) {
		if (index == 1) {
%>			<TR VALIGN=TOP ALIGN=LEFT>
			<TD><%=temp%></TD>
<%		} else if (index == 6) {
			index = 0;
%>			<TD><%=temp%></TD></TR>
<%		} else {
%>			<TD><%=temp%></TD>
<%		}
		index++;
	}
%></TABLE><TABLE border="1">
	<TR VALIGN=TOP ALIGN=LEFT>
		<TD><B>TOTAL</B></TD>
		<TD><B><%= controller.totalImageCount%></B></TD></TR>
</TABLE>
<%
	}
%>

</BODY>
</HTML>
