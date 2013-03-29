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
		if (controller.attemptUploadImage()) {
			%><span class="success">image has been uploaded</span><%
		} else {
			%><span class="error">failed to upload image</span><%
		}
	}

	controller.getUploadImage();
%>

	<p><b>Uploading Module</b></p><p><hr>
	<form name="imageUpload" method="POST" enctype="multipart/form-data" action="uploadImage.jsp">
	<p><li>Please enter a radiology record then input or select the path of the image</P>
	<table>
	<TR VALIGN=TOP ALIGN=LEFT><TD><B>record id:</B></TD><TD>
<!--	<INPUT TYPE="text"NAME="RECORD_ID" VALUE="record_id"><BR></TD></TR>
-->
	<select NAME="RECORD_ID">
		<% for (Record record: controller.records) { %>
			<option value="<%= record.getRecordId() %>">
				<%= record.getRecordId() %>
			</option>
		<% } %>
	</select><BR></TD></TR>
	<tr><th>file path: </th>
	<td><input name="file-path" type="file" size="30" ></input></td></tr>
	<tr><td ALIGN=CENTER COLSPAN="2">
	<input type="submit" name="IMAGEPATH" value="upload"></td></tr>
	</table>
	</form>
	<ul><hr><li><a href="logout.jsp">logout</a></li></ul>

</BODY>
</HTML>
