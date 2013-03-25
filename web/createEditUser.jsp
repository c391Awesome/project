<HTML>
<HEAD>
	<link rel="stylesheet" href="style/style.css"/>
	<TITLE>Create User</TITLE>
</HEAD>

<BODY>
	<h1>Create User<h1>
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
	User selectedUser = controller.selectedUser;
	
	%>
		<FORM NAME="CreateUserForm" ACTION="createUser.jsp" METHOD="post" >
			<TABLE>
				<TR VALIGN=TOP ALIGN=LEFT>
					<TD><B><I>userName</I></B></TD>
					<TD>
						<input type="text" name="USERNAME" value="<%= selectedUser.getUserName() %>">
						<BR>
					</TD>
				</TR>
				<TR VALIGN=TOP ALIGN=LEFT>
					<TD><B><I>password</I></B></TD>
					<TD>
						<input type="text" name="PASSWORD" value="<%= selectedUser.getPassword() %>">
						<BR>
					</TD>
				</TR>
				<TR VALIGN=TOP ALIGN=LEFT>
					<TD><B><I>class</I></B></TD>
					<TD>
						<select name="USER_TYPE">
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
		
	<%
%>



</BODY>
</HTML>


