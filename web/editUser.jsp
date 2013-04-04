<HTML>
<HEAD>
	<link rel="stylesheet" href="style/style.css"/>
	<TITLE>Edit User</TITLE>
</HEAD>

<BODY>
	<p><h1>Edit User</h1></p><p><hr>
<%@ page import="java.sql.*,ca.awesome.*" %>
<% 

	UserManagementController controller = new UserManagementController(
		getServletContext(), request, response, session);

	if (!controller.requireAdmin()) {
		return;
	}

	if (controller.requestIsPost()) {
		if (controller.attemptUpdateUser()) {
			%><span class="success">
				<%= controller.userName %> has been updated 
			</span><%
		} else {
			%><span class="error">failed to update user</span><%
		}
	}

	controller.getEditUser();
	User selectedUser = controller.selectedUser;

		%><h4>Account details for <%= controller.getSelectedUserClassName() %>
			<%= selectedUser.getUserName() %>
		</h4>

		<FORM NAME="EditUserForm" ACTION="editUser.jsp" METHOD="post" >
			<TABLE>
				<input type="hidden" name="USERNAME"
						value="<%= controller.userName %>"/>
				<input type="hidden" name="REGISTERED"
						value="<%= controller.formatDate(selectedUser.getDateRegistered()) %>"/>
				<input type="hidden" name="USER_TYPE"
						value="<%= selectedUser.getType()%>"/>

				<TR VALIGN=TOP ALIGN=LEFT>
					<TD><B><I>password</I></B></TD>
					<TD>
						<input type="text" name="PASSWORD" value="<%= selectedUser.getPassword() %>">
						<BR>
					</TD>
				</TR>

				<TR VALIGN=TOP ALIGN=LEFT>
					<TD><B><I>First Name</I></B></TD>
					<TD>
						<INPUT NAME="FIRSTNAME"
								VALUE="<%= selectedUser.getFirstName() %>"></TD>
					</TR>
			
					<TR VALIGN=TOP ALIGN=LEFT>
					<TD><B><I>Last Name</I></B></TD>
					<TD>
						<INPUT NAME="LASTNAME"
								VALUE="<%= selectedUser.getLastName() %>"></TD>
					</TR>
			
					<TR VALIGN=TOP ALIGN=LEFT>
					<TD><B><I>Address</I></B></TD>
					<TD>
						<INPUT NAME="ADDRESS"
							VALUE="<%= selectedUser.getAddress() %>"></TD>
					</TR>
			
					<TR VALIGN=TOP ALIGN=LEFT>
					<TD><B><I>Email</I></B></TD>
					<TD>
						<INPUT NAME="EMAIL"
								VALUE="<%= selectedUser.getEmail() %>"></TD>
					</TR>
			
					<TR VALIGN=TOP ALIGN=LEFT>
					<TD><B><I>Phone</I></B></TD>
					<TD>
						<INPUT NAME="PHONE"
								VALUE="<%= selectedUser.getPhone() %>"></TD>
					</TR>
			</TABLE>

			<INPUT TYPE="submit" NAME="Submit" VALUE="Save">
		</FORM>
		
	<% if (selectedUser.getType() == User.PATIENT_T) { %>
		<hr/>
		<h4>Family Doctors</h4>
		<ul>
		<% for (User doctor: controller.doctors) { %>
			<li><%= doctor.getUserName() %>
		<% } %>
		</ul>
	
		<form name="assignDoctorForm" action="assignDoctor.jsp" method="get">
			<input type="hidden" name="PATIENT" value="<%=selectedUser.getUserName() %>"/>
			<INPUT TYPE="submit" NAME="ASSIGN" VALUE="Add Doctor">
		</form>
		<form name="unassignDoctorForm" action="unassignDoctor.jsp" method="get">
			<input type="hidden" name="PATIENT" value="<%= selectedUser.getUserName() %>"/>
			<INPUT TYPE="submit" NAME="UNASSIGN" VALUE="Remove Doctor">
		</form>
	<% } %>

	<ul class="nav">
		<li><a href="userManagementConsole.jsp">return to user management</a></h4></li>
		<li><a href="https://github.com/c391Awesome/project/wiki/User-management#to-edit-a-current-user-information" target="_blank">help</a></li>
	</ul>

</BODY>
</HTML>


