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
	<p><b>Radiology Record Search</b></p><p><hr>

<%@ page import="java.sql.*,ca.awesome.*" %>
<%
	SearchController controller = new SearchController(
		getServletContext(), request, response, session);

	if (!controller.requireLogin()) {
		return;
	}

	if (controller.requestIsPost() && !controller.doSearch()) {
		// TODO show error message
	}

%>
	<FORM NAME="search" ACTION="search.jsp" METHOD="post" >
	<fieldset><legend>Record Search:</legend>
	<TABLE>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>Search Terms:</I></B></TD><TD>
	<INPUT TYPE="text" size=50 NAME="QUERY" ><BR></TD></TR>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>Start Date:</I></B></TD><TD>
	<INPUT TYPE="text" id="from" NAME="TIME_FROM" VALUE="Select a Date"><BR></TD></TR>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B><I>End Date:</I></B></TD><TD>
	<INPUT TYPE="text" id="to" NAME="TIME_UNTIL" VALUE="Select a Date"><BR></TD></TR>
	</TABLE>
	</fieldset>
	<INPUT TYPE="submit" NAME="Search" VALUE="Search">
	</FORM>

	<%@ page import="java.sql.*,ca.awesome.*" %>

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
			<TD><B><I>
				<% for (int imageID: result.getImage_id()) { %>
					<a href="GetBigPic?<%= imageID %>">
						<img src="GetOnePic?<%= imageID %>"/>
					</a>
				<% } %>
			</I></B></TD>
		</TR>
	<% } %>

</BODY>

</HTML>
		

