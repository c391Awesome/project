<HTML>
<HEAD>
	<TITLE>Data analysis module</TITLE>
</HEAD>

<BODY>
	<p><b>Data analysis module</b></p><p><hr>
	<FORM NAME="analysis" ACTION="analysisInput.jsp" METHOD="post" >
	<P><li>to generate the OLAB report on number of radiology record:</P>
	<fieldset><legend>select one or more:</legend>
	<TABLE>
	<TR VALIGN=TOP ALIGN=LEFT>
	<TD><input type="checkbox" name="PATIENT_BOX" value="PATIENT"><B>for each patient</B></TD><TR>
	<TR VALIGN=TOP ALIGN=LEFT>
	<TD><input type="checkbox" name="TYPE_BOX" value="TESTTYPE"><B>for each test type</B></TD><TR>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B> period of time:</B></TD><TD>
	<select name="PERIOD">
	<option value="NONE" selected>none</option>
	<option value="WEEKLY">weekly</option>
	<option value="MONTHLY">monthly</option>
	<option value="YEARLY">yearly</option>
	</select></TD></TR>
	</TABLE>
	</fieldset>
	<INPUT TYPE="submit" NAME="getOLAB" VALUE="generate">
	</FORM>

<%@ page import="java.sql.*,ca.awesome.*" %>
<%
	OLAPController controller = new RecordController(
		getServletContext(), request, response, session);

	if (!controller.requireRadiologist()) {
			return;
	}

	if (controller.requestIsPost()) {
		if (controller.attemptGetOLAP()) {

		} else {
			%><span class="error">failed to get OLAP report</span><%
		}
	}


%>

</BODY>
</HTML>
