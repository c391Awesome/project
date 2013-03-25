<HTML>
<HEAD>
	<link rel="stylesheet" href="style/style.css"/>
	<TITLE>Edit User</TITLE>
</HEAD>

<BODY>
	<h1>Edit User<h1>
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
	
	%>
		<h4>Account details for <%= selectedUser.getUserName() %></h4>

		<FORM NAME="EditUserForm" ACTION="editUser.jsp" METHOD="post" >
			<TABLE>
				<input type="hidden" name="USERNAME"
						value="<%= controller.userName %>"/>
				<input type="hidden" name="REGISTERED"
						value="<%= controller.formatDate(selectedUser.getDateRegistered()) %>"/>
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


