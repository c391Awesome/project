<HTML>
<HEAD>
	<link rel="stylesheet" href="style/style.css"/>
	<TITLE>Remove Family Doctor</TITLE>
</HEAD>

<BODY>
	<h1>Remove Family Doctor</h1>
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
		<h4>Remove doctor from <a href="editUser.jsp?USERNAME=<%= controller.patientName %>"><%= controller.patientName %></a></h4>
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



</BODY>
</HTML>


