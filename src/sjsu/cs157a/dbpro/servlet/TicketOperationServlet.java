package sjsu.cs157a.dbpro.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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

/**
 * Servlet implementation class TicketOperationServlet
 */
public class TicketOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger
			.getLogger(TicketOperationServlet.class);
	private static final Map<String, String> sqlsByAttribute = new HashMap<String, String>();
	static{
		String sqlTemplate = "update ticket set %s = ? " +
				"where flightNumber = ? and departureDate = ? and seatClass = ?";
		String[] attributes = new String[]{"availableSeats", "price"};
		for (String s : attributes) {
			sqlsByAttribute.put(s, String.format(sqlTemplate, s));
		}
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if (req.getParameter("op").equals("insert")) {
			String flightNumber = req.getParameter("ticketFlightNumber");
			String departureDate = req.getParameter("departureDate");
			String arrivalDate = req.getParameter("arrivalDate");
			String seatClass = req.getParameter("seatClass");
			String availableSeats = req.getParameter("availableSeats");
			String price = req.getParameter("price");
			
			Connection conn = DbConnection.openConnection();

			
			ResultSet rs = null;
			PreparedStatement prepStmt1 = null;
			
			int ticketCount = 0;
			String sql1 = "select ticketCount from record";
					

			try {
				prepStmt1 = conn.prepareStatement(sql1);
				logger.info("prepStmt: " + prepStmt1.toString());
				rs = prepStmt1.executeQuery();
				if (rs.next()) {
					ticketCount = rs.getInt("ticketCount");
				}
			} catch (SQLException se) {
				se.printStackTrace();
			} finally {
				try {
					prepStmt1.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			ticketCount++;
			logger.info("ticketCount: " + ticketCount);
			int count = ticketCount;
			
			int magCount = 0;
			String partID = "";
			while (count > 0)
			{
				count /= 10;
				magCount++;			
			}
			for (int i = 0; i < 9 - magCount; i++)
			{
				partID += "0";
			}
			logger.info("partID: " + partID);
			String ticketID = "T" + partID + Integer.toString(ticketCount);
			
			PreparedStatement prepStmt = null;
			String sqlError = null;
			int sqlErrorCode = 0;

			String sql = "Insert into ticket values (?, ?, ?, ?, ?, ?, ?)";

			try {
				prepStmt = conn.prepareStatement(sql);
				prepStmt.setString(1, ticketID);
				prepStmt.setString(2, flightNumber);
				prepStmt.setDate(3, Date.valueOf(departureDate));
				prepStmt.setDate(4, Date.valueOf(arrivalDate));
				prepStmt.setString(5, seatClass);
				prepStmt.setInt(6, Integer.parseInt(availableSeats));
				prepStmt.setInt(7, Integer.parseInt(price));

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
			req.setAttribute("sqlError", Helper.parseSqlError(sqlError, sqlErrorCode, "ticket"));
			req.getRequestDispatcher(
					"/WEB-INF/jsp/adminstratorOperationResult.jsp").forward(
					req, resp);
		} else if (req.getParameter("op").equals("update")) {
			// TODO
			String ticketAttribute = req.getParameter("ticketAttribute");
			String ticketAttributeValue = req.getParameter("ticketAttributeValue");
			String flightNum = req.getParameter("flightNum");
			String depDate = req.getParameter("depDate");
			String seatClass = req.getParameter("SeatClass");
						
			Connection conn = DbConnection.openConnection();
			
			PreparedStatement prepStmt = null;
			String sqlError = null;
			
			String sql = sqlsByAttribute.get(ticketAttribute);

			try {
				prepStmt = conn.prepareStatement(sql);
				prepStmt.setString(1, ticketAttributeValue);
				prepStmt.setString(2, flightNum);
				prepStmt.setDate(3, Date.valueOf(depDate));
				prepStmt.setString(4, seatClass);
								
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
		} else {
			// TODO
			String flightNumber = req.getParameter("flightNumber");
			String depDate = req.getParameter("dDate");
			String seatClass = req.getParameter("seatClass");
						
			Connection conn = DbConnection.openConnection();
			
			PreparedStatement prepStmt = null;
			String sqlError = null;
			String sql = "delete from ticket where flightNumber = ? and " +
					"departureDate = ? and seatClass = ?";

			try {
				prepStmt = conn.prepareStatement(sql);
				prepStmt.setString(1, flightNumber);
				prepStmt.setDate(2, Date.valueOf(depDate));
				prepStmt.setString(3, seatClass);
								
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
