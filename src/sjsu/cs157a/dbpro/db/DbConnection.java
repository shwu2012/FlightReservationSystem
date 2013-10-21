package sjsu.cs157a.dbpro.db;

import java.sql.*;

public class DbConnection {
	// JDBC driver name and database URL
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/airlinereservation";
	
	// Database credentials
	static final String USER = "root";
	static final String PASS = "fifa2000";	
	
	public Connection openConnection() {
		Connection conn = null;
	    try{	
			// Register JDBC driver
			Class.forName(JDBC_DRIVER);

			// Open a connection
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
					
	    }catch(SQLException se){
	        //Handle errors for JDBC
	        se.printStackTrace();	    	
	    }catch(Exception e){
	        //Handle errors for Class.forName
	        e.printStackTrace();
	     }
	    return conn;
	}
	
	public void closeConnection(Connection conn){
        if(conn!=null)
        try {
         conn.close();	
        } catch (SQLException se) {
            se.printStackTrace();        	
        }
	}

}
