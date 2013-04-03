<HTML>
<HEAD>
	<link rel="stylesheet" href="style/style.css"/>
	<TITLE>Your Login Result</TITLE>
</HEAD>

<BODY>
<%@ page import="java.sql.*,ca.awesome.*" %>
<% 

	LoginController controller = new LoginController(getServletContext(),
										request, response, session);

	if (controller.requestIsPost() && !controller.attemptLogin()) {
		%><span class="error">Login failed</span><%
	}


	if (controller.userIsLoggedIn()) {
		%>	<p><b>Radiology Information System</b></p><p>
			<% if (controller.user.isPersonalInfoLoaded()) { %>
				Hello, <%= controller.user.getUserType() %> <%= controller.user.getFirstName() %>
						<%= controller.user.getLastName() %>.
			<% } else { %>
				Hello, <%= controller.user.getUserType() %> <%= controller.user.getUserName() %>.
			<% } %>
			<hr>
			<p><b>User Informations</b>
			<ul>
				<li><a href="changePassword.jsp">change password</a></li>
				<li><a href="editPersonalInfo.jsp">edit personal info</a></li>
			</ul>
			<p><b>System Modules</b>
			<ul>
				<li><a href="search.jsp">search radiology records</a></li>
				<% if (controller.userIsAdmin()) { %>
					<li><a href="userManagementConsole.jsp">
						manage users
					</a></li>
					<li><a href="reportGen.jsp">
						generate report
					</a></li>
					<li><a href="analysisInput.jsp">
						analysis on OLAP report
					</a></li>
				<% } %>
				<% if (controller.userIsRadiologist()) { %>
					<li><a href="insertRecord.jsp">
						enter radiology record
					</a></li>
					<li><a href="uploadToRecord.jsp">
						upload image
					</a></li>
				<% } %>
			</ul>
			<p><hr><li><a href="logout.jsp">logout</a></li>
		<%
	} else {
		%>
		<FORM NAME="LoginForm" ACTION="login.jsp" METHOD="post" >
			
			<P>To login successfully, you need to submit a valid username and password</P>
			<TABLE>
				<TR VALIGN=TOP ALIGN=LEFT>
					<TD><B><I>Username:</I></B></TD>
					<TD>
						<INPUT TYPE="text" NAME="<%= LoginController.USERNAME_FIELD %>">
						<BR>
					</TD>
				</TR>
				<TR VALIGN=TOP ALIGN=LEFT>
					<TD><B><I>Password:</I></B></TD>
					<TD>
						<INPUT TYPE="password" NAME="<%= LoginController.PASSWORD_FIELD %>"></TD>
				</TR>
			</TABLE>

			<INPUT TYPE="submit" NAME="Submit" VALUE="LOGIN">
		</FORM>
		<%
	}
%>



</BODY>
</HTML>
