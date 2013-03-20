package ca.awesome;

import java.io.*;
import javax.servlet.ServletContext;
import java.sql.*;

/*
	Reads database credentials from CREDENTIALS_FILE and
	creates a jdbc connection to the database.

	The credentials file should have two lines:
	username
	password

	A connection is not made in the constructor, instead we
	wait for the connect() method. If a connection hasn't
	been made, or the connection has been closed, then connect
	will be null.
*/
public class DatabaseConnection {
	private static String CREDENTIALS_FILE = "/WEB-INF/db_creds.txt";
	private static String DRIVERNAME = "oracle.jdbc.driver.OracleDriver";
	private static String DATABASE = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";


	private Connection connection;

	public DatabaseConnection()
	{
	}
	
	public boolean connect(ServletContext context)
	{
		String userName, password;
		try {
			InputStream stream = context.getResourceAsStream(CREDENTIALS_FILE);
			if (stream == null) {
				throw new FileNotFoundException("Can't find "
							+ CREDENTIALS_FILE);
			}
			InputStreamReader streamReader = new InputStreamReader(stream);
			BufferedReader credentialsReader = new BufferedReader(streamReader);
	
			userName = credentialsReader.readLine().trim();
			password = credentialsReader.readLine().trim();
	
			credentialsReader.close();
		} catch (IOException credentialsException) {
			throw new RuntimeException("Failed to read database credentials",
						credentialsException);
		}

		try {
			Class driverClass = Class.forName(DRIVERNAME);
			DriverManager.registerDriver((Driver) driverClass.newInstance());

			connection = DriverManager.getConnection(DATABASE, userName,
							password);
			connection.setAutoCommit(true);
		} catch(Exception connectionException) {
			throw new RuntimeException("Failed to connect to database",
						connectionException);
		}
		return true;
	}

	public void close()
	{
		if (connection == null) {
			return;
		}

		try {
			connection.close();
			connection = null;
		} catch (SQLException e) {
			// TODO
		}
		connection = null;
	}

	public Statement createStatement() throws SQLException
	{
		return connection.createStatement();
	}
};
