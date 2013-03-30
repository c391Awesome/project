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
			%><span class="success">image has been uploaded
			<br><TABLE border="1"><TR VALIGN=TOP ALIGN=LEFT>
			<TD>record id</TD><TD>image id</TD></TR>
			<TR VALIGN=TOP ALIGN=LEFT>
			<TD><%= controller.record_id %></TD>
			<TD><%= controller.image_id %></TD></TR></TABLE>
			</span><%
		} else {
			%><span class="error">failed to upload image
			<br><TABLE border="1"><TR VALIGN=TOP ALIGN=LEFT>
			<TD>record id</TD><TD>image id</TD></TR>
			<TR VALIGN=TOP ALIGN=LEFT>
			<TD><%= controller.record_id %></TD>
			<TD><%= controller.image_id %></TD></TR></TABLE>
			</span><%
		}
	}
%>

	<p><b>Uploading Module</b></p><p><hr>
	<form name="imageUpload" method="POST" enctype="multipart/form-data" action="uploadImage.jsp">
	<p><li>Please select the path of the image</P>
	<table>
	<tr><th>select file: </th><td>
	<input type="file" name="UPLOADFILE" size="30" ></input></td></tr>
	<tr><td ALIGN=CENTER COLSPAN="2">
	<input type="submit" name="UPLOAD" value="upload"></td></tr>
	</table>
	</form>
	<ul><hr><li><a href="logout.jsp">logout</a></li></ul>

</BODY>
</HTML>
