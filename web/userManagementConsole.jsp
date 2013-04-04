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
	<p><h1>Create User / Edit User</h1></p><p><hr>
	<li><a href="createUser.jsp"><b>create a user</b></a></li><br>
	<fieldset><legend><b>edit a user:</b></legend>
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
		</fieldset>
		<INPUT TYPE="submit" NAME="edit" VALUE="edit">
	</FORM>
	<ul class="nav">
		<li><a href="login.jsp">back</a></li>
		<li><a href="https://github.com/c391Awesome/project/wiki/User-management">help</a></li>
	</ul>
</BODY>
</HTML>

