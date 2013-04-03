<HTML>
<HEAD>
	<TITLE>Data Analysis Module</TITLE>
</HEAD>

<BODY>
	<p><b>Data analysis module</b></p><p><hr>

<%@ page import="java.sql.*,ca.awesome.*" %>
<%
	OLAPController controller = new OLAPController(
		getServletContext(), request, response, session);

	if (!controller.requireAdmin()) {
			return;
	}
	controller.setDropBoxValue();
%>

<FORM NAME="analysis" ACTION="analysisInput.jsp" METHOD="post" >
	<P><li>to generate the OLAB report on number of radiology record images:</P>
	<fieldset><legend>select one or more:</legend>
	<TABLE>
	<TR VALIGN=TOP ALIGN=LEFT>
	<TD><input type="checkbox" name="PATIENT_BOX" value="PATIENT"><B>for each patient</B></TD>
	<TD><B><I>OR</I> choose a specific patient :</B></TD>
	<TD><select NAME="ONE_PATIENT">
		<option value="NONE" selected>none</option>
		<% for (User patient: controller.patients) { %>
			<option value="<%= patient.getUserName() %>">
				<%= patient.getUserName() %>
			</option>
		<% } %>
	</select><BR></TD></TR>
	<TR VALIGN=TOP ALIGN=LEFT>
	<TD><input type="checkbox" name="TYPE_BOX" value="TESTTYPE"><B>for each test type</B></TD>
	<TD><B><I>OR</I> choose a specific test type :</B></TD>
	<TD><select NAME="ONE_TYPE">
		<option value="NONE" selected>none</option>
		<% for (String type: controller.testTypes) { %>
			<option value="<%= type%>">
				<%= type%>
			</option>
		<% } %>
	</select><BR></TD></TR>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B>period of time <I>(drill down / roll up)</I>:</B></TD>
	<TD><select name="PERIOD">
	<option value="NONE" selected>none</option>
	<option value="YEARLY">yearly</option>
	<option value="MONTHLY">monthly</option>
	<option value="WEEKLY">weekly</option>
	</select></TD></TR>
	</TABLE>
	</fieldset>
	<INPUT TYPE="submit" NAME="getOLAB" VALUE="generate">
	</FORM>

<%	if (controller.requestIsPost()) {
		if (!controller.getInput()) {
%>			<span class="error">
			conflict on input!</span>
<%		} else {
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
		<TD><B><%= controller.totalImageCount%></B></TD>
		</TR>	
</TABLE>
<%		}
	}
%>
<p><hr><li><a href="login.jsp">back</a></li>

</BODY>
</HTML>
