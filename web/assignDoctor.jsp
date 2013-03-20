<HTML>
<HEAD>
	<link rel="stylesheet" href="style/style.css"/>
	<TITLE>Assign Family Doctor</TITLE>
</HEAD>

<BODY>
<%@ page import="java.sql.*,ca.awesome.*" %>
<% 

	UserManagementController controller = new UserManagementController(
		getServletContext(), request, response, session);

	if (!controller.requireAdmin()) {
		return;
	}

	%>
		<FORM NAME="AssignDoctorForm" ACTION="assignDoctor.jsp" METHOD="post" >
			<TABLE>
				<TR VALIGN=TOP ALIGN=LEFT>
					<TD><B><I>patient username:</I></B></TD>
					<TD>
						<select NAME="<%= UserManagementController.PATIENT_FIELD%>">
							<% for(User doctor: controller.doctors) { %>
								<option value="<%= doctor.getUserName() %>">
									<%= doctor.getUserName() %>
								</option>
							<% } %>
						</select>
						<BR>
					</TD>
				</TR>
				<TR VALIGN=TOP ALIGN=LEFT>
					<TD><B><I>Doctor:</I></B></TD>
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

			<INPUT TYPE="submit" NAME="Submit" VALUE="LOGIN">
		</FORM>
		
	<%
%>



</BODY>
</HTML>

