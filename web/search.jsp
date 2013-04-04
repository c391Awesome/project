<HTML>
<HEAD>
	<link rel="stylesheet" href="style/style.css"/>
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" />
	<link rel="stylesheet" href="/resources/demos/style.css" />
	<script>
  	$(function() {
 		$( "#from" ).datepicker({
		 	defaultDate: "+1w",
		 	changeMonth: true,
		 	numberOfMonths: 3,
		 	onClose: function( selectedDate ) {
		 	$( "#to" ).datepicker( "option", "minDate", selectedDate );
		 	}
		 });
	 	 $( "#to" ).datepicker({
		 	defaultDate: "+1w",
		 	changeMonth: true,
		 	numberOfMonths: 3,
		 	onClose: function( selectedDate ) {
		 	$( "#from" ).datepicker( "option", "maxDate", selectedDate );
		 	}
		 });
	 });
	</script>
	<TITLE>Radiology Record Search</TITLE>
</HEAD>

<BODY>
	<p><h1>Radiology Record Search</h1></p><p><hr>

<%@ page import="java.sql.*,ca.awesome.*" %>
<%
	SearchController controller = new SearchController(
		getServletContext(), request, response, session);

	if (!controller.requireLogin()) {
		return;
	}

	if (controller.requestIsPost() && !controller.doSearch()) {
		%><span class="error">Your search could not be completed.</span><%
	}


%>
	<FORM NAME="search" ACTION="search.jsp" METHOD="post" >
	<fieldset><legend>Record Search:</legend>
	<TABLE>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>Search Terms:</I></B></TD><TD>
	<INPUT TYPE="text" size=50 NAME="QUERY" ><BR></TD></TR>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>Start Date:</I></B></TD><TD>
	<INPUT TYPE="text" id="from" NAME="TIME_FROM" VALUE="Select a Date"> (optional) <BR></TD></TR>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>End Date:</I></B></TD><TD>
	<INPUT TYPE="text" id="to" NAME="TIME_UNTIL" VALUE="Select a Date"> (optional) <BR></TD></TR>
	</TABLE>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>Rank by</I></B></TD><TD>
		<input type="radio" name="RANKING" value="DATE_ASC">most recent last</input>
		<input type="radio" name="RANKING" value="DATE_DES">most recent first</input>
		<input type="radio" name="RANKING" value="SCORE" checked>most relevant first</input>
	</fieldset>
	<INPUT TYPE="submit" NAME="Search" VALUE="Search">
	</FORM>

	<%@ page import="java.sql.*,ca.awesome.*" %>

	<h5><%= controller.results.size() %>
		record<%= (controller.results.size() == 1)? "" : "s" %> found</h5>
	<TABLE border="1">
		<TR VALIGN=TOP ALIGN=LEFT>
			<TD><B><I>Patient</I></B></TD>
			<TD><B><I>Doctor</I></B></TD>
			<TD><B><I>Radiologist</I></B></TD>
			<TD><B><I>Test Type</I></B></TD>
			<TD><B><I>Prescribing Date</I></B></TD>
			<TD><B><I>Test Date</I></B></TD>
			<TD><B><I>Diagnosis</I></B></TD>
			<TD><B><I>Description</I></B></TD>
			<TD><B><I>Thumbnails</I></B></TD>
		</TR>
	<% for (Record result: controller.results) { %>
		<TR VALIGN=TOP ALIGN=LEFT>
			<TD><B><I><%= result.getPatient() %></I></B></TD>
			<TD><B><I><%= result.getDoctor() %></I></B></TD>
			<TD><B><I><%= result.getRadiologist() %></I></B></TD>
			<TD><B><I><%= result.getTestType() %></I></B></TD>
			<TD><B><I><%= controller.formatDate(result.getPrescribingDate()) %></I></B></TD>
			<TD><B><I><%= controller.formatDate(result.getTestDate()) %></I></B></TD>
			<TD><B><I><%= result.getDiagnosis() %></I></B></TD>
			<TD><B><I><%= result.getDescription() %></I></B></TD>
			<TD ALIGN=RIGHT><B><I>
				<% for (int imageID: result.getImage_id()) { %>
					<a href="displayImage.jsp?<%= imageID %>" target="_blank">
						<img src="GetOnePic?<%= imageID %>"/>
					</a>
				<% } %>

				<% if (controller.userIsRadiologist()
					&& result.getRadiologist().equals(
						controller.user.getUserName())) { %>
					<a href="uploadImage.jsp?RECORD_ID=<%= result.getRecordId() %>">add an image to this record</a>
				<% } %>
			</I></B></TD>
		</TR>
	<% } %>
	</TABLE>
	
	<ul class="nav">
		<li><a href="login.jsp">back</a></li>
		<li><a href="https://github.com/c391Awesome/project/wiki/Search">help</a></li>
	</ul>
</BODY>

</HTML>
		

