package ca.awesome;

import java.sql.*;


public class User {
	public static final int ADMINISTRATOR_T = 1;
	public static final int PATIENT_T = 2;
	public static final int DOCTOR_T = 4;
	public static final int RADIOLOGIST_T = 8;
	
	private String userName;
	private String password;
	private Integer type;
	private Date dateRegistered;

	public User(String name, String password, Integer type, Date registered) {
		this.userName = name;
		this.password = password;
		this.type = type;
		this.dateRegistered = dateRegistered;
	}

	public String getUserName() {
		if (userName == null) {
			throw new MissingFieldException("userName", this);
		}
		return userName;
	}

	public String getPassword() {
		if (password == null) {
			throw new MissingFieldException("password", this);
		}
		return password;
	}

	public int getType() {
		if (type == null) {
			throw new MissingFieldException("type", this);
		}
		return type.intValue();
	}

	
	static public User findUserByName(String name,
		DatabaseConnection connection) {

		ResultSet results = null;
		Statement statement = null;
		try {
			statement = connection.createStatement();
			results = statement.executeQuery(
				"select user_name, password, class, date_registered"
				+ " from users where user_name = '" + name + "'"
			);
			
			if (results == null || !results.next()) {
				return null;
			}

			String password = results.getString(2);
			String type = results.getString(3);
			Date registered = results.getDate(4);

			connection.close();

			return new User(name, password, getTypeFromString(type),
							registered);
		} catch (SQLException e) {
			connection.close();
			throw new RuntimeException("failed to findUserByName()", e);
		}
	}

	private static Integer getTypeFromString(String type) {
		if (type.equals("a")) {
			return new Integer(ADMINISTRATOR_T);
		} else if (type.equals("p")) {
			return new Integer(PATIENT_T);
		} else if (type.equals("d")) {
			return new Integer(DOCTOR_T);
		} else if (type.equals("r")) {
			return new Integer(RADIOLOGIST_T);
		}

		return null;
	}
};
