package sjsu.cs157a.dbpro.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import sjsu.cs157a.dbpro.db.DbConnection;

/**
 * Servlet implementation class cancelReservationServlet
 */
public class CancelReservationServlet extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger
			.getLogger(CancelReservationServlet.class);

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException
	{
		// TODO Auto-generated method stub

		String puserName = (String) req.getSession().getAttribute("username");

		String reservationID = req.getParameter("reservationNumber");
		
		logger.info("reservationID: " + reservationID);
		
		Connection conn = DbConnection.openConnection();

		PreparedStatement prepStmt = null;

		String sql = "delete from reservation " + "where reservationID = ?";

		// logger.info("write update sql");

		try
		{
			prepStmt = conn.prepareStatement(sql);
			prepStmt.setString(1, reservationID);
			// test sql
			logger.info("prepStmt: " + prepStmt.toString());

			prepStmt.executeUpdate();

		}
		catch (SQLException se)
		{
			se.printStackTrace();
			// sqlError = se.getMessage();

		}
		finally
		{
			try
			{
				prepStmt.close();
			}
			catch (SQLException e)
			{
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		DbConnection.closeConnection(conn);

		// logger.info("close connection");

		logger.info("Username: " + puserName);
		/*
		 * if (sqlError == null) {
		 * req.getRequestDispatcher("/WEB-INF/jsp/editContactInfo.jsp"
		 * ).forward(req, resp); } else { req.setAttribute("sqlError",
		 * sqlError); req.setAttribute("type", "registerPassenger");
		 * req.getRequestDispatcher
		 * ("/WEB-INF/jsp/passengerDashboard.jsp").forward(req, resp); }
		 */

		req.getRequestDispatcher("/WEB-INF/jsp/cancelReservation.jsp").forward(
				req, resp);
	}

}
