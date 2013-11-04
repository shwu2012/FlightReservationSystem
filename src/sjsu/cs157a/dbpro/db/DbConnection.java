package sjsu.cs157a.dbpro.db;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

import org.apache.log4j.Logger;

public class DbConnection {

	private static final Logger logger = Logger.getLogger(DbConnection.class);

	static {
		Properties prop = new Properties();
		try {
			// load a properties file from class path, inside static method
			prop.load(DbConnection.class.getClassLoader().getResourceAsStream(
					"db.properties"));

			// get the property value and print it out
			jdbcDriver = prop.getProperty("db.driver");
			dbUrl = prop.getProperty("db.url");
			dbUsername = prop.getProperty("db.username");
			dbPassword = prop.getProperty("db.password");
			logger.info("database configuration is loaded");
		} catch (IOException ex) {
			ex.printStackTrace();
			logger.error("database configuration cannot be loaded");
		}

	}

	// JDBC driver name and database URL
	private static String jdbcDriver;
	private static String dbUrl;

	// Database credentials
	private static String dbUsername;
	private static String dbPassword;

	// No public constructor for the helper class without any instance methods.
	private DbConnection() {
	}

	public static Connection openConnection() {
		Connection conn = null;
		try {
			// Register JDBC driver
			Class.forName(jdbcDriver);

			// Open a connection
			conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

		} catch (SQLException se) {
			// Handle errors for JDBC
			se.printStackTrace();
		} catch (Exception e) {
			// Handle errors for Class.forName
			e.printStackTrace();
		}
		return conn;
	}

	public static void closeConnection(Connection conn) {
		if (conn != null)
			try {
				conn.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
	}

}
