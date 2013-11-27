package sjsu.cs157a.dbpro.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import sjsu.cs157a.dbpro.db.DbConnection;
import sjsu.cs157a.dbpro.domain.Helper;

public class FlightOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger
			.getLogger(FlightOperationServlet.class);
	private static final Map<String, String> sqlByAttr = new HashMap<String, String>();
	static{
		String sqlTemplate = "update flight set %s = ? where flightNumber = ?";
		String[] attributes  = new String[]{"aircraftModel","departureTime", "arrivalTime"};
		for(String s: attributes){
			sqlByAttr.put(s, String.format(sqlTemplate, s));
		}
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		if (req.getParameter("op").equals("insert")) {
			String flightNumber = req.getParameter("flightNumber");
			String airlineCode = req.getParameter("airlineCode");
			String aircraftModel = req.getParameter("aircraftModel");
			String departAirportCode = req.getParameter("departAirportCode");
			String arrivalAirportCode = req.getParameter("arrivalAirportCode");
			String departureTime = req.getParameter("departureTime");
			String arrivalTime = req.getParameter("arrivalTime");
			boolean isOvernight = req.getParameter("overnight") != null;

			Connection conn = DbConnection.openConnection();

			PreparedStatement prepStmt = null;
			String sqlError = null;
			int sqlErrorCode = 0;
			String sql = "Insert into flight " + "values (" + "?, " + "?, "
					+ "?, " + "?, " + "?, " + "?, " + "?, " + "?" + ")";

			try {
				prepStmt = conn.prepareStatement(sql);
				prepStmt.setString(1, flightNumber);
				prepStmt.setString(2, airlineCode);
				prepStmt.setString(3, aircraftModel);
				prepStmt.setString(4, departAirportCode);
				prepStmt.setString(5, arrivalAirportCode);
				prepStmt.setString(6, departureTime);
				prepStmt.setString(7, arrivalTime);
				prepStmt.setBoolean(8, isOvernight);
				// test sql
				logger.info("prepStmt: " + prepStmt.toString());
				prepStmt.executeUpdate();
			} catch (SQLException se) {
				se.printStackTrace();
				sqlError = se.getMessage();
				sqlErrorCode = se.getErrorCode();
				logger.info("sqlError: " + sqlError);
				logger.info("sqlErrorCode: " + sqlErrorCode);
			} finally {
				try {
					prepStmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			DbConnection.closeConnection(conn);
			req.setAttribute("sqlError", Helper.parseSqlError(sqlError, sqlErrorCode, "flight"));
			req.getRequestDispatcher(
					"/WEB-INF/jsp/adminstratorOperationResult.jsp").forward(
					req, resp);
		} else if (req.getParameter("op").equals("update")) {
			String flightAttribute = req.getParameter("flightAttribute");
			String newAttributeValue = req.getParameter("newAttributeValue");
			String flightNumber = req.getParameter("flightNumber");			
			
			Connection conn = DbConnection.openConnection();

			PreparedStatement prepStmt = null;
			String sqlError = null;
			int sqlErrorCode = 0;
			String sql = sqlByAttr.get(flightAttribute);

			try {
				prepStmt = conn.prepareStatement(sql);
				prepStmt.setString(1, newAttributeValue);
				prepStmt.setString(2, flightNumber);
				// test sql
				logger.info("prepStmt: " + prepStmt.toString());
				prepStmt.executeUpdate();
			} catch (SQLException se) {
				se.printStackTrace();
				sqlError = se.getMessage();
				sqlErrorCode = se.getErrorCode();
			} finally {
				try {
					prepStmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			DbConnection.closeConnection(conn);
			req.setAttribute("sqlError", Helper.parseSqlError(sqlError, sqlErrorCode, "flight"));
			req.getRequestDispatcher(
					"/WEB-INF/jsp/adminstratorOperationResult.jsp").forward(
					req, resp);			
		} else {
			String flightNumber = req.getParameter("flightNumber");			
			
			Connection conn = DbConnection.openConnection();

			PreparedStatement prepStmt = null;
			String sqlError = null;
			String sql = "delete from flight where flightNumber = ?";

			try {
				prepStmt = conn.prepareStatement(sql);
				prepStmt.setString(1, flightNumber);
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
			req.setAttribute("sqlError", sqlError);
			req.getRequestDispatcher(
					"/WEB-INF/jsp/adminstratorOperationResult.jsp").forward(
					req, resp);
		}
	}
}
