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
		// request is post
		%><span class="success">Information changed!</span>
		<p><hr><h4><a href="login.jsp">back</a></h4><%
	} else {
		controller.getUpdateInfo();
		if (controller.hasError()) {
			%><span class="error"><%=controller.error%></span><%
		}

		%>
		<p><h1>Edit Personal Information</h1></p><p><hr>

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

	<ul class="nav">
		<li><a href="login.jsp">back</a></li>
		<li><a href="https://github.com/c391Awesome/project/wiki/Login#editing-your-personal-info" target="_blank">help</a></li>
	</ul>

</BODY>
</HTML>
