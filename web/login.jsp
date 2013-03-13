<HTML>
<HEAD>

<TITLE>Your Login Result</TITLE>
</HEAD>

<BODY>
<%@ page import="java.sql.*,ca.awesome.*" %>
<% 

	LoginController controller = new LoginController(getServletContext());
	if(request.getParameter("Submit") != null) {
	        //get the user input from the login page
			if (controller.attemptLogin(request)) {
				%>Successfully logged in as <%= controller.userName %><%
			} else {
				%>Login failed<%
			}
	} else {
		%>
		<FORM NAME="LoginForm" ACTION="login.jsp" METHOD="post" >
			
			<P>To login successfully, you need to submit a valid username and password</P>
			<TABLE>
				<TR VALIGN=TOP ALIGN=LEFT>
					<TD><B><I>Username:</I></B></TD>
					<TD>
						<INPUT TYPE="text" NAME="<%= LoginController.USERNAME_FIELD %>" VALUE="userid">
						<BR>
					</TD>
				</TR>
				<TR VALIGN=TOP ALIGN=LEFT>
					<TD><B><I>Password:</I></B></TD>
					<TD>
						<INPUT TYPE="password" NAME="<%= LoginController.PASSWORD_FIELD %>" VALUE="password"></TD>
				</TR>
			</TABLE>

			<INPUT TYPE="submit" NAME="Submit" VALUE="LOGIN">
		</FORM>
		<%
	}
%>



</BODY>
</HTML>
