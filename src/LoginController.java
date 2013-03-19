package ca.awesome;

import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;


public class LoginController {
	public static String USERNAME_FIELD = "USERNAME";
	public static String PASSWORD_FIELD = "PASSWORD";

	// view-accessible fields
	public User user;
	
	private ServletContext context;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private HttpSession session;

	public LoginController(ServletContext context, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) {
		this.context = context;
		this.request = request;
		this.response = response;
		this.session = session;

		this.user = (User)session.getAttribute("user");
	}

	public boolean userIsLoggedIn() {
		return this.user == null;
	}
		
	public boolean attemptLogin() {
		String userName = request.getParameter(USERNAME_FIELD).trim();
		String password = request.getParameter(PASSWORD_FIELD).trim();

		DatabaseConnection connection = getDatabaseConnection(context);
		user = User.findUserByName(userName, connection);
		if (user == null) {
			return false;
		}

		session.setAttribute("user", user);
		return user.getPassword().equals(password);
	}

	public boolean requestIsPost() {
		return "POST".equalsIgnoreCase(request.getMethod());
	}

	private DatabaseConnection getDatabaseConnection(ServletContext context) {
		DatabaseConnection connection = new DatabaseConnection();
		if (!connection.connect(context)) {
			connection.close();
			throw new RuntimeException("Failed to connect to database");
		}
		return connection;
	}
};
