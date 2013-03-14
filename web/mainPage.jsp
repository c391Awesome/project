<HTML>
<HEAD>


<TITLE>Your Login Result</TITLE>
</HEAD>

<BODY>
<!--
 -->
<%@ page import="java.sql.*" %>
<% 

	if(request.getParameter("UserMg") != null) {
%>
		<p><b>User management module</b></p>
		<FORM NAME="manage" ACTION="manage.jsp" METHOD="post" >
		<TABLE>
		<TR VALIGN=TOP ALIGN=LEFT><TD><li><B>manage table users:</B></TD></TR>
		<TR VALIGN=TOP ALIGN=LEFT><TD><INPUT TYPE="submit" NAME="InsertUsers" VALUE="insert"></TD></TR>
		<TR VALIGN=TOP ALIGN=LEFT><TD><INPUT TYPE="submit" NAME="UpdateUsers" VALUE="update"></TD></TR>
		<TR VALIGN=TOP ALIGN=LEFT><TD><INPUT TYPE="submit" NAME="DeleteUsers" VALUE="delete"></TD></TR>
		<TR VALIGN=TOP ALIGN=LEFT><TD><li><B>manage table persons:</B></TD></TR>
		<TR VALIGN=TOP ALIGN=LEFT><TD><INPUT TYPE="submit" NAME="InsertPersons" VALUE="insert"></TD></TR>
		<TR VALIGN=TOP ALIGN=LEFT><TD><INPUT TYPE="submit" NAME="UpdatePersons" VALUE="update"></TD></TR>
		<TR VALIGN=TOP ALIGN=LEFT><TD><INPUT TYPE="submit" NAME="DeletePersons" VALUE="delete"></TD></TR>
		<TR VALIGN=TOP ALIGN=LEFT><TD><li><B>manage table family_doctor:</B></TD></TR>
		<TR VALIGN=TOP ALIGN=LEFT><TD><INPUT TYPE="submit" NAME="InsertFamilydoc" VALUE="insert"></TD></TR>
		<TR VALIGN=TOP ALIGN=LEFT><TD><INPUT TYPE="submit" NAME="UpdateFamilydoc" VALUE="update"></TD></TR>
		<TR VALIGN=TOP ALIGN=LEFT><TD><INPUT TYPE="submit" NAME="DeleteFamilydoc" VALUE="delete"></TD></TR>
		</TABLE>
		</FORM>
<%
	}
	if(request.getParameter("RepoGen") != null) {
%>
		<p><b>Report generating module</b></p>
		<FORM NAME="reportGen" ACTION="reportGen.jsp" METHOD="post" >
		<P>to get the list of all patients with a specified diagnosis for a given time period</P>
		<TABLE>
		<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>diagnosis:</I></B></TD><TD><INPUT TYPE="text"NAME="DIAGNOSIS" VALUE="diagnosis"><BR></TD></TR>
		<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>time from:</I></B></TD><TD><INPUT TYPE="text"NAME="TIME_FROM" VALUE="time_from"><BR></TD></TR>
		<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>time until:</I></B></TD><TD><INPUT TYPE="text"NAME="TIME_UNTIL" VALUE="time_until"><BR></TD></TR>
		</TABLE>
		<INPUT TYPE="submit" NAME="GENREPO" VALUE="generate_report">
		</FORM>
<%
	}
	if(request.getParameter("Upload") != null) {
		out.println("<p><b>Uploading module</b></p>");
	}
	if(request.getParameter("Search") != null) {
		out.println("<p><b>Search module</b></p>");
	}
	if(request.getParameter("Analysis") != null) {
		out.println("<p><b>Data analysis module</b></p>");
	}
%>



</BODY>
</HTML>

