<html><head>
	<title>
	View Image	
	</title>
</head>
<body bgcolor="#000000" text="#cccccc">
<%@ page import="java.sql.*,ca.awesome.*" %>
<%
	ImageController controller = new ImageController(
		getServletContext(), request, response, session);

	controller.getDisplayImage();
%>
	<center><img src="GetOnePic?full<%= controller.image_id %>">
	<h3><%= controller.image_id %></h3>
</body>
</html>
