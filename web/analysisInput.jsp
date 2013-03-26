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
	<TD><input type="checkbox" name="columns" value="patient_name"><B>for each patient</B></TD><TR>
	<TR VALIGN=TOP ALIGN=LEFT>
	<TD><input type="checkbox" name="columns" value="test_type"><B>for each test type</B></TD><TR>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B> period of time:</B></TD><TD>
	<select name="period">
	<option value="none" selected>none</option>
	<option value="weekly">weekly</option>
	<option value="monthly">monthly</option>
	<option value="yearly">yearly</option>
	</select></TD></TR>
	</TABLE>
	</fieldset>
	<INPUT TYPE="submit" NAME="getOLAB" VALUE="generate">
	</FORM>

<%@ page import="java.sql.*,ca.awesome.*" %>
<%
	

%>

</BODY>
</HTML>
