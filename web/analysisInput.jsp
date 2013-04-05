<HTML>
<HEAD>
	<TITLE>Data Analysis Module</TITLE>
	<link rel="stylesheet" href="style/style.css"/>
</HEAD>

<BODY>
	<p><h1>Data analysis module</h1></p><p><hr>

<%@ page import="java.sql.*,ca.awesome.*" %>
<%
	OLAPController controller = new OLAPController(
		getServletContext(), request, response, session);

	if (!controller.requireAdmin()) {
		return;
	}
	if (controller.recordTableEmpty()) {
%>		<span class="error">table radiology_record is empty!</span>
		<ul class="nav">
			<li><a href="login.jsp">back</a></li>
			<li><a href="https://github.com/c391Awesome/project/wiki/Data-analysis" target="_blank">help</a></li>
		</ul>
<%		return;
	}
	controller.setDropBoxValue();
	controller.readParameters();
%>

<FORM NAME="analysis" ACTION="analysisInput.jsp" METHOD="post" >
	<P><li>to generate the OLAP report on number of radiology record images:</P>
	<fieldset><legend>select one or more:</legend>
	<TABLE>

	<TR VALIGN=TOP ALIGN=LEFT>
	<TD><input type="radio" name="PATIENT_BOX" value="EACH_PATIENT" <%=controller.eachPatientChoosen()%>>
		<B>each patient</B></TD>
	<TD><input type="radio" name="PATIENT_BOX" value="A_PATIENT" <%=controller.aPatientChoosen()%>>
		<B>one patient</B></TD>
	<TD><select NAME="ONE_PATIENT">
		<option value="NONE" <%=controller.noPatientSelected()%>>none</option>
		<% for (User patient: controller.patients) { %>
			<option value="<%= patient.getUserName() %>" <%=controller.onePatientSelected(patient.getUserName())%>>
				<%= patient.getUserName() %>
			</option>
		<% } %>
	</select></TD>
	<TD><input type="radio" name="PATIENT_BOX" value="ALL_PATIENT" <%=controller.allPatientChoosen()%>>
		<B>all patients</B></TD></TR>

	<TR VALIGN=TOP ALIGN=LEFT>
	<TD><input type="radio" name="TYPE_BOX" value="EACH_TYPE" <%=controller.eachTypeChoosen()%>>
		<B>each test type</B></TD>
	<TD><input type="radio" name="TYPE_BOX" value="A_TYPE" <%=controller.aTypeChoosen()%>>
		<B>one test type</B></TD>
	<TD><select NAME="ONE_TYPE">
		<option value="NONE" <%=controller.noTypeSelected()%>>none</option>
		<% for (String type: controller.testTypes) { %>
			<option value="<%= type%>" <%=controller.oneTypeSelected(type)%>>
				<%= type%>
			</option>
		<% } %>
	</select></TD>
	<TD><input type="radio" name="TYPE_BOX" value="ALL_TYPE" <%=controller.allTypeChoosen()%>>
		<B>all test types</B></TD></TR>
	</TABLE>
	<TABLE>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B>period of time <I>(drill down / roll up)</I>:</B></TD>
	<TD><select name="PERIOD">
	<option value="NONE" selected>all time</option>
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

	<ul class="nav">
		<li><a href="login.jsp">back</a></li>
		<li><a href="https://github.com/c391Awesome/project/wiki/Data-analysis" target="_blank">help</a></li>
	</ul>

</BODY>
</HTML>
