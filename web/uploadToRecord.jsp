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

	if (controller.requestIsPost()) {
		if (controller.attemptSelectRecord()) {
			%><span class="success">record selected
			<br><TABLE border="1"><TR VALIGN=TOP ALIGN=LEFT>
			<TD>record id</TD></TR>
			<TR VALIGN=TOP ALIGN=LEFT>
			<TD><%= controller.record_id %></TD></TR></TABLE>
			</span><%
		} else {
			%><span class="error">failed to upload image
			<br><TABLE border="1"><TR VALIGN=TOP ALIGN=LEFT>
			<TD>record id</TD></TR>
			<TR VALIGN=TOP ALIGN=LEFT>
			<TD><%= controller.record_id %></TD></TR></TABLE>
			</span><%
		}
	}
	controller.getUploadImage();
%>
	<p><b>Uploading Module</b></p><p><hr>
	<form name="uploadToRecord" method="POST" action="uploadToRecord.jsp">
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
	<ul><hr><li><a href="uploadImage.jsp">upload image to record</a></li></ul>

</BODY>
</HTML>
