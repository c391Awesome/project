<HTML>
<HEAD>
	<link rel="stylesheet" href="style/style.css"/>
	<TITLE>Change Password</TITLE>
</HEAD>

<BODY>
<%@ page import="java.sql.*,ca.awesome.*" %>
<% 

	LoginController controller = new LoginController(getServletContext(),
										request, response, session);
	if (!controller.requireLogin()) {
		return;
	}

	if (controller.requestIsPost() && controller.attemptChangePassword()) {
		%><span class="success">Password changed!</span>
		<p><hr><h4><a href="login.jsp">back</a></h4><%
	} else {
		if (controller.hasError()) {
			%><span class="error"><%=controller.error%></span><%
		}

		%>
		<p><h1>Change Password</h1></p><p><hr>
		
		<FORM NAME="ChangePasswordForm" ACTION="changePassword.jsp" METHOD="post" >
			
			<P>Please enter and confirm your desired password below</P>
			<TABLE>
				<TR VALIGN=TOP ALIGN=LEFT>
					<TD><B><I>Password:</I></B></TD>
					<TD>
						<INPUT TYPE="password" NAME="<%= LoginController.PASSWORD_FIELD %>" VALUE=""></TD>
				</TR>
				<TR VALIGN=TOP ALIGN=LEFT>
					<TD><B><I>Confirm Password:</I></B></TD>
					<TD>
						<INPUT TYPE="password" NAME="<%= LoginController.PASSWORD_CONF_FIELD %>"></TD>
				</TR>
			</TABLE>

			<INPUT TYPE="submit" NAME="Submit" VALUE="Change Password">
		</FORM>
		<p><hr><h4><a href="login.jsp">back</a></h4>
		<%
	}
%>



</BODY>
</HTML>

