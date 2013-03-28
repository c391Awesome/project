<HTML>
<HEAD>
	<link rel="stylesheet" href="style/style.css"/>
	<TITLE>Assign Family Doctor</TITLE>
</HEAD>

<BODY>
	<h1>Assign Family Doctor</h1>
<%@ page import="java.sql.*,ca.awesome.*" %>
<% 

	UserManagementController controller = new UserManagementController(
		getServletContext(), request, response, session);

	if (!controller.requireAdmin()) {
		return;
	}

	if (controller.requestIsPost()) {
		if (controller.attemptAssignDoctor()) {
			%><span class="success">
				<%= controller.patientName %>
				assigned to doctor
				<%= controller.doctorName %>
			</span><%
		} else {
			%><span class="error">failed to assign doctor</span><%
		}
	}

	controller.getAssignDoctor();

	%>
		<h4>Assign Doctor to <a href="editUser.jsp?USERNAME=<%= controller.patientName %>"><%= controller.patientName %></a></h4>
		<FORM NAME="AssignDoctorForm" ACTION="assignDoctor.jsp" METHOD="post" >
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

			<INPUT TYPE="submit" NAME="Submit" VALUE="Assign">
		</FORM>
		
	<%
%>



</BODY>
</HTML>

