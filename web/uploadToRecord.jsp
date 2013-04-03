<HTML>
<HEAD>
	<TITLE>Uploading Module</TITLE>
</HEAD>

<BODY>

<%@ page import="java.sql.*,ca.awesome.*" %>
<%
	ImageController controller = new ImageController(
		getServletContext(), request, response, session);

	if (!controller.requireRadiologist()) {
		return;
	}

	if (controller.requestIsGet()) { 
		controller.attemptSelectRecord();
	}

	controller.getUploadToRecord();
%>
	<p><b>Uploading Module</b></p><p><hr>
	<form name="uploadToRecord" method="GET" action="uploadImage.jsp">
	<p><li>Please enter a radiology record then input or select the path of the image</P>
	<table>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B>record id:</B></TD><TD>
	<select NAME="RECORD_ID">
		<% for (Record record: controller.records) { %>
			<option value="<%= record.getRecordId() %>">
				<%= record.getRecordId() %>
			</option>
		<% } %>
	</select><BR></TD></TR>
	<tr><TD><input type="submit" name="SUBMIT" value="select"></td></tr>
	</table>
	</form>
	<p><hr><li><a href="login.jsp">back</a></li>

</BODY>
</HTML>
