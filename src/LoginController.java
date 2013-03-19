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

	public LoginController(ServletContext context) {
		this.context = context;
	}

	public boolean attemptLogin(HttpServletRequest request) {
		String userName = request.getParameter(USERNAME_FIELD).trim();
		String password = request.getParameter(PASSWORD_FIELD).trim();

		DatabaseConnection connection = getDatabaseConnection(context);
		user = User.findUserByName(userName, connection);
		if (user == null) {
			return false;
		}

		return user.getPassword().equals(password);
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
