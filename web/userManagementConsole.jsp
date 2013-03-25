<HTML>
<HEAD>
	<link rel="stylesheet" href="style/style.css"/>
	<TITLE>User management</TITLE>
</HEAD>

<BODY>
<%@ page import="java.sql.*,ca.awesome.*" %>
<% 

	UserManagementController controller = new UserManagementController(
		getServletContext(), request, response, session);


	if (!controller.requireAdmin()) {
		return;
	}

	controller.getManagementConsole();

	%>
	<h3>Create A User<h3>
	<a href="createUser.jsp">create a user</a>
	<hr/>

	<h3>Edit A User<h3>
	<FORM NAME="editUserForm" ACTION="editUser.jsp" METHOD="get" >
		<TABLE>
				<TR VALIGN=TOP ALIGN=LEFT>
					<TD><B><I>Username:</I></B></TD>
					<TD>
						<select NAME="USERNAME">
							<% for(User user: controller.users) { %>
								<option value="<%= user.getUserName() %>">
									<%= user.getUserName() %>
								</option>
							<% } %>
						</select>
						<BR>
					</TD>
				</TR>
			</TABLE>

			<INPUT TYPE="submit" NAME="edit" VALUE="edit">
		</FORM>
</BODY>
</HTML>

