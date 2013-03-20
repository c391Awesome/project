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
		%>
			Hello, <%= controller.user.getFirstName() %>
					<%= controller.user.getLastName() %>.
			<ul>
				<li><a href="logout.jsp">logout</a></li>
				<li><a href="changePassword.jsp">change password</a></li>
				<li><a href="editPersonalInfo.jsp">editPersonalInfo</a></li>
			</ul>
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
