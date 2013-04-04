<HTML>
<HEAD>
	<link rel="stylesheet" href="style/style.css"/>
	<TITLE>Create User</TITLE>
</HEAD>

<BODY>
	<p><h1>Create User</h1></p><p><hr>
<%@ page import="java.sql.*,ca.awesome.*" %>
<% 

	UserManagementController controller = new UserManagementController(
		getServletContext(), request, response, session);

	if (!controller.requireAdmin()) {
		return;
	}

	if (controller.requestIsPost()) {
		if (controller.attemptCreateUser()) {
			%><span class="success">
				<%= controller.userName %> has been created
			</span><%
		} else {
			%><span class="error">failed to create user</span><%
		}
	}

	controller.getCreateUser();

	%>
		<FORM NAME="CreateUserForm" ACTION="createUser.jsp" METHOD="post" >
			<TABLE>
				<TR VALIGN=TOP ALIGN=LEFT>
					<TD><B><I>userName</I></B></TD>
					<TD>
						<input type="text" name="<%= UserManagementController.USERNAME_FIELD %>"/>
						<BR>
					</TD>
				</TR>
				<TR VALIGN=TOP ALIGN=LEFT>
					<TD><B><I>password</I></B></TD>
					<TD>
						<input type="text" name="<%= UserManagementController.PASSWORD_FIELD%>"/>
						<BR>
					</TD>
				</TR>
				<TR VALIGN=TOP ALIGN=LEFT>
					<TD><B><I>class</I></B></TD>
					<TD>
						<select name="<%= UserManagementController.USER_TYPE_FIELD%>">
							<option value="<%= User.PATIENT_T %>">
								patient
							</option>
							<option value="<%= User.DOCTOR_T%>">
								doctor
							</option>
							<option value="<%= User.RADIOLOGIST_T %>">
								radiologist
							</option>
						</select>
						<BR>
					</TD>
				</TR>
			</TABLE>

			<INPUT TYPE="submit" NAME="Submit" VALUE="Create">
		</FORM>
		
	<%
%>
	<ul class="nav">
		<li><a href="userManagementConsole.jsp">return to user management</a></li>
		<li><a href="https://github.com/c391Awesome/project/wiki/User-management#to-create-a-new-user" target="_blank">help</a></li>
	</ul>

</BODY>
</HTML>


