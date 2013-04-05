<HTML>
<HEAD>
	<link rel="stylesheet" href="style/style.css"/>
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
	if (controller.recordTableEmpty()) {
%>		<span class="error">table radiology_record is empty!</span>
		<ul class="nav">
			<li><a href="login.jsp">back</a></li>
			<li><a href="https://github.com/c391Awesome/project/wiki/Image-uploading#creating-a-radiology-record" target="_blank">help</a></li>
		</ul>
<%		return;
	}
	if (controller.requestIsGet()) { 
		controller.attemptSelectRecord();
	}

	controller.getUploadToRecord();
%>
	<p><h1>Uploading Module</h1></p><p><hr>
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
	<ul class="nav">
		<li><a href="login.jsp">back</a></li>
		<li><a href="https://github.com/c391Awesome/project/wiki/Image-uploading#creating-a-radiology-record" target="_blank">help</a></li>
	</ul>

</BODY>
</HTML>
