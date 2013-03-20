<HTML>
<HEAD>
	<link rel="stylesheet" href="style/style.css"/>
	<TITLE>Edit PersonalInfo</TITLE>
</HEAD>

<BODY>
<%@ page import="java.sql.*,ca.awesome.*" %>
<% 

	LoginController controller = new LoginController(getServletContext(),
										request, response, session);
	if (!controller.requireLogin()) {
		return;
	}

	if (controller.requestIsPost() && controller.attemptUpdateInfo()) {
		%><span class="success">Information changed!</span><%
	} else {
		if (controller.hasError()) {
			%><span class="error"><%=controller.error%></span><%
		}

		%>
		<FORM NAME="ChangePasswordForm" ACTION="editPersonalInfo.jsp" METHOD="post" >
			
			<P>Update your personal information below</P>
			<%
				User user = controller.user;
				String labels[] = {"First Name", "Last Name", "Address",
									"Email", "Phone"};
				String fields[] = {LoginController.FIRST_NAME,
									LoginController.LAST_NAME,
									LoginController.ADDRESS,
									LoginController.EMAIL,
									LoginController.PHONE};
				String values[] = {user.getFirstName(), user.getLastName(),
									user.getAddress(), user.getEmail(),
									user.getPhone()};
			%>
	
			<TABLE>
				<% for (int i = 0; i < fields.length; i++) { %>
						<TR VALIGN=TOP ALIGN=LEFT>
						<TD><B><I><%= labels[i] %></I></B></TD>
						<TD>
							<INPUT NAME="<%= fields[i] %>"
									VALUE="<%= values[i] %>"></TD>
						</TR>
				<% } %>
			</TABLE>

			<INPUT TYPE="submit" NAME="Submit" VALUE="Submit">
		</FORM>
		<%
	}
%>



</BODY>
</HTML>
