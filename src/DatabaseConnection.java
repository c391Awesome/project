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

	private static String userName = null;
	private static String password = null;

	private boolean allowClose = true;
	private Connection connection = null;


	public DatabaseConnection()
	{
	}

	public static void initialize(ServletContext context)
	{
		if (userName != null && password != null) {
			return;
		}

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
		} catch(Exception e) {
			throw new RuntimeException("Failed to load jdbc driver!", e);
		}
	}
	
	public boolean connect()
	{
		try {
			connection = DriverManager.getConnection(DATABASE, userName, password);
			connection.setAutoCommit(true);
		} catch (SQLException e) {
			return false;
		}

		return true;
	}

	public void setTransactionIsolation(int level) throws SQLException {
		connection.setTransactionIsolation(level);
	}

	public void setAutoCommit(boolean autoCommit) throws SQLException {
		connection.setAutoCommit(autoCommit);
	}

	public void setAllowClose(boolean allowClose) {
		this.allowClose = allowClose;
	}

	public void close()
	{
		if (!allowClose || connection == null) {
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

	public void commit() throws SQLException
	{
		connection.commit();
	}

	public boolean rollback()
	{
		try {
			connection.rollback();
			return true;
		} catch (SQLException e) {
			return false;
		}
	}

	public Statement createStatement() throws SQLException
	{
		return connection.createStatement();
	}

	public PreparedStatement prepareStatement(String sql) throws SQLException
	{
		return connection.prepareStatement(sql);
	}
};
