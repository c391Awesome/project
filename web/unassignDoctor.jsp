<HTML>
<HEAD>
	<link rel="stylesheet" href="style/style.css"/>
	<TITLE>Remove Family Doctor</TITLE>
</HEAD>

<BODY>
	<p><h1>Remove Family Doctor</h1></p><p><hr>
	
<%@ page import="java.sql.*,ca.awesome.*" %>
<% 

	UserManagementController controller = new UserManagementController(
		getServletContext(), request, response, session);

	if (!controller.requireAdmin()) {
		return;
	}

	if (controller.requestIsPost()) {
		if (controller.attemptUnassignDoctor()) {
			%><span class="success">
				<%= controller.patientName %>
				removed from doctor
				<%= controller.doctorName %>
			</span><%
		} else {
			%><span class="error">failed to remove doctor</span><%
		}
	}

	controller.getUnassignDoctor();

	%>
		<b>Remove doctor from <a href="editUser.jsp?USERNAME=<%= controller.patientName %>"><%= controller.patientName %></a></b>
		<FORM NAME="UnassignDoctorForm" ACTION="unassignDoctor.jsp" METHOD="post" >
			<TABLE>
				<input type="hidden"
					NAME="<%= UserManagementController.PATIENT_FIELD%>"
					VALUE="<%= controller.patientName %>"/>

				<TR VALIGN=TOP ALIGN=LEFT>
					<TD><B><I>doctor:</I></B></TD>
					<TD>
						<select NAME="<%= UserManagementController.DOCTOR_FIELD %>">
							<% for(User doctor: controller.doctors) { %>
								<option value="<%= doctor.getUserName() %>">
									<%= doctor.getUserName() %>
								</option>
							<% } %>
						</select>
					</TD>
				</TR>
			</TABLE>

			<INPUT TYPE="submit" NAME="Submit" VALUE="Remove">
		</FORM>
		
	<%
%>
	<ul class="nav">
		<li><a href="userManagementConsole.jsp">return to user management</a></li>
		<li><a href="https://github.com/c391Awesome/project/wiki/User-management#assign-or-remove-doctors-for-a-patient">help</a></li>
	</ul>


</BODY>
</HTML>


