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

	controller.getUploadImage();
%>

	<p><b>Uploading Module</b></p><p><hr>
	<form name="imageUpload" method="POST" enctype="multipart/form-data" action="uploadImage.jsp">
	<p><li>Please select the image upload to record <%= controller.record_id %></P>
	<table>
	<tr><th>file path: </th><td>
	<input type="file" name="UPLOADFILE" size="30" ></input></td></tr>
	<tr><td ALIGN=CENTER COLSPAN="2">
	<input type="submit" name="UPLOAD" value="upload"></td></tr>
	</table>
	</form>
	<p><hr>

<%
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
	<p><li><a href="uploadToRecord.jsp">back to choose record</a></li>

</BODY>
</HTML>
