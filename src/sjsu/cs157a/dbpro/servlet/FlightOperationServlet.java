package sjsu.cs157a.dbpro.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import sjsu.cs157a.dbpro.db.DbConnection;

public class FlightOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger logger = Logger
			.getLogger(FlightOperationServlet.class);

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		if (req.getParameter("op").equals("insert")){
			String flightNumber = req.getParameter("flightNumber");
			String airlineCode = req.getParameter("airlineCode");
			String aircraftModel = req.getParameter("aircraftModel");
			String departAirportCode = req.getParameter("departAirportCode");
			String arrivalAirportCode = req.getParameter("arrivalAirportCode");
			String departureTime = req.getParameter("departureTime");
			String arrivalTime = req.getParameter("arrivalTime");
			boolean isOvernight = req.getParameter("overnight") == null;
			
			Connection conn = DbConnection.openConnection();
			
			PreparedStatement prepStmt = null;
			String sqlError = null;
			String sql = "Insert into flight "
					+ "values ("
					+ "?, "
					+ "?, "
					+ "?, "
					+ "?, "
					+ "?, "
					+ "?, "
					+ "?, "
					+ "?"
					+ ")";
			
			try {
				prepStmt = conn.prepareStatement(sql);
				prepStmt.setString(1, flightNumber);
				prepStmt.setString(2, airlineCode);
				prepStmt.setString(3, aircraftModel);
				prepStmt.setString(4, departAirportCode);
				prepStmt.setString(5, arrivalAirportCode);
				//prepStmt.setTime(6, departureTime);
				//prepStmt.setTime(7, arrivalTime);
				prepStmt.setBoolean(8, isOvernight);
				// test sql
				logger.info("prepStmt: " + prepStmt.toString());
				prepStmt.executeUpdate();
			} catch (SQLException se) {
				se.printStackTrace();
				sqlError = se.getMessage();
			} finally {
				try {
					prepStmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			DbConnection.closeConnection(conn);			

			if (sqlError == null) {

			} else {
				
			}			
			
		} else if (req.getParameter("op").equals("update")){
			
		} else {
			
		}
	}
}
