package ca.awesome;

import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;


public class LoginController {
	public static String USERNAME_FIELD = "USERNAME";
	public static String PASSWORD_FIELD = "PASSWORD";

	public String userName = "";
	
	private ServletContext context;

	public LoginController(ServletContext context) {
		this.context = context;
	}

	public boolean attemptLogin(HttpServletRequest request) {
		String userName = request.getParameter(USERNAME_FIELD).trim();
		String password = request.getParameter(PASSWORD_FIELD).trim();

		DatabaseConnection connection = new DatabaseConnection();
		if (!connection.connect(context)) {
			connection.close();
			return false;
		}

		// now do SQL stuff, in the future, this will be in the User model
		ResultSet results = null;
		Statement statement = null;
		try {
			statement = connection.createStatement();
			results = statement.executeQuery(
				"select password from users where user_name = '"
				+ userName + "'"
			);
			
			while (results != null && results.next()) {
				String actualPassword = results.getString(1).trim();
				if (actualPassword.equals(password) && !password.equals("")) {		
					connection.close();
					this.userName = userName;
					return true;
				}
			}
		} catch (SQLException e) {
			// todo
			connection.close();
			return false;
		}

		connection.close();
		return false;
	}
};
