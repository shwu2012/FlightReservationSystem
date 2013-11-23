package sjsu.cs157a.dbpro.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import sjsu.cs157a.dbpro.db.DbConnection;
import sjsu.cs157a.dbpro.domain.FirstStatistic;
import sjsu.cs157a.dbpro.domain.Reservation;
import sjsu.cs157a.dbpro.domain.SecondStatistic;

/**
 * Servlet implementation class AdministratorStatisticsServlet
 */
@WebServlet("/AdministratorStatisticsServlet")
public class AdministratorStatisticsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger
			.getLogger(AdministratorStatisticsServlet.class);   

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		Connection conn = DbConnection.openConnection();
		PreparedStatement prepStmt = null;
		String sql = null;
		String sqlError = null;
		ResultSet rs = null;
		
		if (req.getParameter("order").equals("first"))
		{
			String airlineName = req.getParameter("airline_name");
			sql = "select ticket.flightNumber, departureDate, avg(age) as avgAge"
					+ "from ticket join reservation join flight join passenger "
					+ "where ticket.ticketID = reservation.ticketID "
					+ "and ticket.flightNUmber = flight.flightNUmber "
					+ "and reservation.passengerID = passenger.passengerID "
					+ "and airlineCode in (select airlineCode from airline where airlineName = ?) "
					+ "group by ticket.flightnumber, departureDate";
									
			try {
				prepStmt = conn.prepareStatement(sql);
				prepStmt.setString(1, airlineName);
				
				rs = prepStmt.executeQuery();
				
				List<FirstStatistic> firstStatistics = new ArrayList<FirstStatistic>();
				
				while (rs.next())
				{
					FirstStatistic firstStatistic = new FirstStatistic();

					firstStatistic.setFlightNumber(rs.getString("flightNumber"));
					firstStatistic.setDepartureDate(Date.valueOf(rs.getString("departureDate")));
					firstStatistic.setAvgAge(Integer.parseInt(rs.getString("avgAge")));
					firstStatistics.add(firstStatistic);
				}
				
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
					"/WEB-INF/jsp/administratorStatisticsResult1.jsp").forward(
					req, resp);
			
		}
		else if (req.getParameter("order").equals("second"))
		{
			String departureAirportCode = req.getParameter("depart_airport");
			String arrivalAirportCode = req.getParameter("arrival_airport");
			
			sql = "select flightnumber "
					+ "from (select flightnumber, count(*) as c "
					+ "from reservation join ticket "
					+ "where reservation.ticketID = ticket.ticketID "
					+ "and flightNumber = (select flightnumber from Flight "
					+ "where departureAirportCode = ? and arrivalAirportCode = ?) "
					+ "group by flightnumber) R "
					+ "where c = (select  mac(c) from (select flightnumber, count(*) as c "
					+ "from reservation join ticket "
					+ "where reservation.ticketID = ticket.ticketID "
					+ "and flightNumber = (select flightnumber from Flight "
					+ "where departureAirportCode = ? and arrivalAirportCode = ?) "
					+ "group by flightnumber) R1) ";
	
		
			try {
				prepStmt = conn.prepareStatement(sql);
				prepStmt.setString(1, departureAirportCode);
				prepStmt.setString(1, arrivalAirportCode);
				
				List<SecondStatistic> secondStatistics = new ArrayList<SecondStatistic>();
				
				while (rs.next())
				{
					SecondStatistic secondStatistic = new SecondStatistic();
					secondStatistic.setFlightNumber(rs.getString("flightNumber"));
					secondStatistics.add(secondStatistic);
				}
				
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
					"/WEB-INF/jsp/administratorStatisticsResult2.jsp").forward(
					req, resp);
			
		}
		else if (req.getParameter("order").equals("third"))
		{
			
		}
		else if (req.getParameter("order").equals("fourth"))
		{
			
		}
		else if (req.getParameter("order").equals("fifth"))
		{
			
		}
		else if (req.getParameter("order").equals("sixth"))
		{
			
		}
		else if (req.getParameter("order").equals("seventh"))
		{
			
		}
		else if (req.getParameter("order").equals("eighth"))
		{
			
		}
		
	}

}
