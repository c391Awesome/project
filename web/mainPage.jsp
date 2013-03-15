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
		<p><b>User management module</b></p><p><hr>
		<FORM NAME="manage" ACTION="manage.jsp" METHOD="post" ><p>
		<TABLE>
		<TR VALIGN=TOP ALIGN=LEFT><th colspan="3"><li>manage users table:</th></TR>
		<TR VALIGN=TOP ALIGN=LEFT>
		<TD><INPUT TYPE="submit" NAME="InsertUsers" VALUE="insert"></TD>
		<TD><INPUT TYPE="submit" NAME="UpdateUsers" VALUE="update"></TD>
		<TD><INPUT TYPE="submit" NAME="DeleteUsers" VALUE="delete"></TD></TR>
		<TR VALIGN=TOP ALIGN=LEFT><th colspan="3"><li>manage persons table:</th></TR>
		<TR VALIGN=TOP ALIGN=LEFT>
		<TD><INPUT TYPE="submit" NAME="InsertPersons" VALUE="insert"></TD>
		<TD><INPUT TYPE="submit" NAME="UpdatePersons" VALUE="update"></TD>
		<TD><INPUT TYPE="submit" NAME="DeletePersons" VALUE="delete"></TD></TR>
		<TR VALIGN=TOP ALIGN=LEFT><th colspan="3"><li>manage family_doctor table:</th></TR>
		<TR VALIGN=TOP ALIGN=LEFT>
		<TD><INPUT TYPE="submit" NAME="InsertFamilydoc" VALUE="insert"></TD>
		<TD><INPUT TYPE="submit" NAME="UpdateFamilydoc" VALUE="update"></TD>
		<TD><INPUT TYPE="submit" NAME="DeleteFamilydoc" VALUE="delete"></TD></TR>
		</TABLE>
		</FORM>
<%
	}
	if(request.getParameter("RepoGen") != null) {
%>
		<p><b>Report generating module</b></p><p><hr>
		<FORM NAME="reportGen" ACTION="reportGen.jsp" METHOD="post" >
		<P><li>to get the list of all patients with a specified diagnosis for a given time period :</P>
		<fieldset><legend>report information:</legend>
		<TABLE>
		<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>diagnosis:</I></B></TD><TD>
		<INPUT TYPE="text" size=50 NAME="DIAGNOSIS" VALUE="diagnosis"><BR></TD></TR>
		<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>time from:</I></B></TD><TD>
		<INPUT TYPE="text"NAME="TIME_FROM" VALUE="time_from"><BR></TD></TR>
		<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>time until:</I></B></TD><TD>
		<INPUT TYPE="text"NAME="TIME_UNTIL" VALUE="time_until"><BR></TD></TR>
		</TABLE>
		</fieldset>
		<INPUT TYPE="submit" NAME="GenReport" VALUE="generate report">
		</FORM>
<%
	}
	if(request.getParameter("Upload") != null) {
%>
		<p><b>Uploading module</b></p>
		<p><hr>		
		<form name="imageUpload" method="POST" enctype="multipart/form-data" action="servlet/UploadImage">
		<p><li>Please enter a radiology record then input or select the path of the image!</P>
		<table>
		<TR VALIGN=TOP ALIGN=LEFT><TD><B>record id:</B></TD><TD>
		<INPUT TYPE="text"NAME="RECORD_ID" VALUE="record_id"><BR></TD></TR>
    		<tr><th>file path: </th>
    		<td><input name="file-path" type="file" size="30" ></input></td></tr>
  		<tr><td ALIGN=CENTER COLSPAN="2">
		<input type="submit" name="UploadImage" value="upload"></td></tr>
		</table>
		</form>
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
		<INPUT TYPE="PRESCRIBINGDATE"NAME="TIME_UNTIL" VALUE="prescribing_date"><BR></TD></TR>
		<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>test date:</I></B></TD><TD>
		<INPUT TYPE="text"NAME="TESTDATE" VALUE="test_date"><BR></TD></TR>
		<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>diagnosis:</I></B></TD><TD>
		<INPUT TYPE="text" size=50 NAME="DIAGNOSIS" VALUE="diagnosis"><BR></TD></TR>
		<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>description:</I></B></TD><TD>
		<textarea rows = 10 cols = 65 name=DESCRIPTION></textarea>
		</TABLE>
		</fieldset>
		<INPUT TYPE="submit" NAME="InsertRecord" VALUE="submit new record">
		</FORM>
		
<%
	}
	if(request.getParameter("Search") != null) {
%>
		<p><b>Search module</b></p>
		<p><hr>
		<FORM NAME="searching" ACTION="search.jsp" METHOD="post" >
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
<%
	}
	if(request.getParameter("Analysis") != null) {
%>
		<p><b>Data analysis module</b></p>
		<p><hr>
		<FORM NAME="analysis" ACTION="OLAB.jsp" METHOD="post" >
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

<%
	}
%>



</BODY>
</HTML>

