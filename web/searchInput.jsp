<HTML>
<HEAD>
	<TITLE>Search module</TITLE>
</HEAD>

<BODY>
	<p><b>Search module</b></p><p><hr>
	<FORM NAME="searching" ACTION="searchInput.jsp" METHOD="post" >
	<P><li>to search the database for a list of relevant radiology records :</P>
	<fieldset><legend>search for:</legend>
	<TABLE>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>keywords:</I></B></TD><TD>
	<INPUT TYPE="text" size=100 NAME="KEYWORDS" VALUE="keywords"><BR></TD></TR>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>time from:</I></B></TD><TD>
	<INPUT TYPE="text"NAME="TIME_FROM" VALUE="time_from"><BR></TD></TR>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>time until:</I></B></TD><TD>
	<INPUT TYPE="text"NAME="TIME_UNTIL" VALUE="time_until"><BR></TD></TR>
	</TABLE>
	</fieldset>
	<INPUT TYPE="submit" NAME="SubmitSearch" VALUE="search">
	</FORM>

<%@ page import="java.sql.*,ca.awesome.*" %>
<%
	

%>

</BODY>
</HTML>
