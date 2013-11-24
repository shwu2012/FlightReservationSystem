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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import sjsu.cs157a.dbpro.db.DbConnection;
import sjsu.cs157a.dbpro.domain.EighthStatistic;
import sjsu.cs157a.dbpro.domain.FirstStatistic;
import sjsu.cs157a.dbpro.domain.FourthStatistic;
import sjsu.cs157a.dbpro.domain.SecondStatistic;
import sjsu.cs157a.dbpro.domain.SeventhStatistic;
import sjsu.cs157a.dbpro.domain.ThirdStatistic;

/**
 * Servlet implementation class AdministratorStatisticsServlet
 */
public class AdministratorStatisticsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger
			.getLogger(AdministratorStatisticsServlet.class);   

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Connection conn = DbConnection.openConnection();
		PreparedStatement prepStmt = null;
		String sql = null;
		String sqlError = null;
		ResultSet rs = null;
		
		if (req.getParameter("order").equals("first"))
		{
			String airlineName = req.getParameter("airline_name");
			sql = "select ticket.flightNumber, departureDate, avg(age) as avgAge "
					+ "from ticket join reservation join flight join passenger "
					+ "where ticket.ticketID = reservation.ticketID "
					+ "and ticket.flightNUmber = flight.flightNUmber "
					+ "and reservation.passengerID = passenger.passengerID "
					+ "and airlineCode in (select airlineCode from airline where airlineName = ?) "
					+ "group by ticket.flightnumber, departureDate";
				
			List<FirstStatistic> firstStatistics = new ArrayList<FirstStatistic>();
			try {
				prepStmt = conn.prepareStatement(sql);
				prepStmt.setString(1, airlineName);
				logger.info("prepStmt: " + prepStmt.toString());
				rs = prepStmt.executeQuery();
				
				while (rs.next())
				{
					FirstStatistic firstStatistic = new FirstStatistic();
					firstStatistic.setFlightNumber(rs.getString("flightNumber"));
					firstStatistic.setDepartureDate(Date.valueOf(rs.getString("departureDate")));
					firstStatistic.setAvgAge(rs.getInt("avgAge"));
					firstStatistics.add(firstStatistic);
				}
			} catch (SQLException se) {
				se.printStackTrace();
				sqlError = se.getMessage();
			} finally {
				try {
					prepStmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			DbConnection.closeConnection(conn);
			req.setAttribute("sqlError", sqlError);
			req.setAttribute("firstStatistics", firstStatistics);
			req.setAttribute("airlineName", airlineName);
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
					+ "and flightNumber in (select flightnumber from Flight "
					+ "where departureAirportCode = ? and arrivalAirportCode = ?) "
					+ "group by flightnumber) R "
					+ "where c in (select max(c) from (select flightnumber, count(*) as c "
					+ "from reservation join ticket "
					+ "where reservation.ticketID = ticket.ticketID "
					+ "and flightNumber in (select flightnumber from Flight "
					+ "where departureAirportCode = ? and arrivalAirportCode = ?) "
					+ "group by flightnumber) R1)";
			
			List<SecondStatistic> secondStatistics = new ArrayList<SecondStatistic>();
		
			try {
				prepStmt = conn.prepareStatement(sql);
				prepStmt.setString(1, departureAirportCode);
				prepStmt.setString(2, arrivalAirportCode);
				prepStmt.setString(3, departureAirportCode);
				prepStmt.setString(4, arrivalAirportCode);
				logger.info("prepStmt: " + prepStmt.toString());
				rs = prepStmt.executeQuery();
				
				while (rs.next())
				{
					SecondStatistic secondStatistic = new SecondStatistic();
					secondStatistic.setFlightNumber(rs.getString("flightNumber"));
					secondStatistics.add(secondStatistic);
				}
								
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
			req.setAttribute("departureAirportCode", departureAirportCode);
			req.setAttribute("arrivalAirportCode", arrivalAirportCode);
			req.setAttribute("secondStatistics", secondStatistics);
			req.getRequestDispatcher(
					"/WEB-INF/jsp/administratorStatisticsResult2.jsp").forward(
					req, resp);
			
		}
		else if (req.getParameter("order").equals("third"))
		{
			
			int age = Integer.parseInt(req.getParameter("age"));
			String flightNumber = req.getParameter("flight_number");
			
			sql = "select firstName, lastName, email from passenger " +
					"where age > ? and " +
					"passengerID in (select passengerID FROM Reservation " +
					"WHERE ticketID IN  (SELECT ticketID FROM Ticket WHERE  flightNumber = ?))";
			
			List<ThirdStatistic> thirdStatistics = new ArrayList<ThirdStatistic>();
			try {
				prepStmt = conn.prepareStatement(sql);
				prepStmt.setInt(1, age);
				prepStmt.setString(2, flightNumber);
				logger.info("prepStmt: " + prepStmt.toString());
				rs = prepStmt.executeQuery();
				
				while (rs.next())
				{
					ThirdStatistic thirdStatistic = new ThirdStatistic();
					thirdStatistic.setFirstName(rs.getString("firstName"));
					thirdStatistic.setLastName(rs.getString("lastName"));
					thirdStatistic.setEmail(rs.getString("email"));
					thirdStatistics.add(thirdStatistic);
				}
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
			req.setAttribute("flightNumber", flightNumber);
			req.setAttribute("age", age);
			req.setAttribute("thirdStatistics", thirdStatistics);
			req.getRequestDispatcher(
					"/WEB-INF/jsp/administratorStatisticsResult3.jsp").forward(
					req, resp);
			
		}
		else if (req.getParameter("order").equals("fourth"))
		{
			int age = Integer.parseInt(req.getParameter("average_age"));
			sql = "select airlineName from airline where airlineCode in" +
					" (select airlineCode from employee group by airlineCode having avg(age) > ?)";
				
			List<FourthStatistic> fourthStatistics = new ArrayList<FourthStatistic>();
			try {
				prepStmt = conn.prepareStatement(sql);
				prepStmt.setInt(1, age);
				logger.info("prepStmt: " + prepStmt.toString());
				rs = prepStmt.executeQuery();
				
				while (rs.next())
				{
					FourthStatistic fourthStatistic = new FourthStatistic();
					fourthStatistic.setAirlineName(rs.getString("airlineName"));
					fourthStatistics.add(fourthStatistic);
				}
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
			req.setAttribute("age", age);
			req.setAttribute("fourthStatistics", fourthStatistics);
			req.getRequestDispatcher(
					"/WEB-INF/jsp/administratorStatisticsResult4.jsp").forward(
					req, resp);
		}
		else if (req.getParameter("order").equals("fifth"))
		{
			String airlineName = req.getParameter("airline_name");
			String departureDate = req.getParameter("depart_date");
			
			sql = "select sum(price) as revenue from ticket natural join flight " 
			    + "WHERE airlineCode = (SELECT airlineCode from airline where airlineName = ?) "
				+ "AND departureDate = ?";
		
			int revenue = 0;
			try {
				prepStmt = conn.prepareStatement(sql);
				prepStmt.setString(1, airlineName);
				prepStmt.setString(2, departureDate);
				logger.info("prepStmt: " + prepStmt.toString());
				rs = prepStmt.executeQuery();
				
				rs.next();
				revenue = rs.getInt("revenue");
							
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
			req.setAttribute("airlineName", airlineName);
			req.setAttribute("departureDate", departureDate);
			req.setAttribute("revenue", revenue);
			req.getRequestDispatcher(
					"/WEB-INF/jsp/administratorStatisticsResult5.jsp").forward(
					req, resp);
			
		}
		else if (req.getParameter("order").equals("sixth"))
		{
			String flightNumber = req.getParameter("flight_number");
			
			sql = "select count(*) as numOfTicket "
			+ "from reservation join ticket join flight "
			+ "where reservation.ticketID = ticket.ticketID and ticket.flightNumber = flight.flightNumber " 
			+ "and ticket.flightNumber = ?";
			
			int numOfTicket = 0;
			try {
				prepStmt = conn.prepareStatement(sql);
				prepStmt.setString(1, flightNumber);
				logger.info("prepStmt: " + prepStmt.toString());
				rs = prepStmt.executeQuery();
				
				rs.next();
				numOfTicket = rs.getInt("numOfTicket");
							
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
			req.setAttribute("flightNumber", flightNumber);
			req.setAttribute("numOfTicket", numOfTicket);
			req.getRequestDispatcher(
					"/WEB-INF/jsp/administratorStatisticsResult6.jsp").forward(
					req, resp);			
			
		}
		else if (req.getParameter("order").equals("seventh"))
		{
			sql = "SELECT airportName, c as maxNumOfDeparturedFlights " +
					"FROM (SELECT airportName, COUNT(*) AS c " +
					"FROM Flight Join Airport where airportCode = departureAirportCode " +
					"GROUP BY airportName) R " +
					"where c in (select max(c) from " +
					"(SELECT airportName, COUNT(*) AS c " +
					"FROM Flight Join Airport where airportCode = departureAirportCode " +
					"GROUP BY airportName) R)";
			
			List<SeventhStatistic> seventhStatistics = new ArrayList<SeventhStatistic>();
			try {
				prepStmt = conn.prepareStatement(sql);
				logger.info("prepStmt: " + prepStmt.toString());
				rs = prepStmt.executeQuery();
				
				while (rs.next())
				{
					SeventhStatistic seventhStatistic = new SeventhStatistic();
					seventhStatistic.setAirportName(rs.getString("airportName"));
					seventhStatistic.setMaxNumOfDeparturedFlights(rs.getInt("maxNumOfDeparturedFlights"));
					seventhStatistics.add(seventhStatistic);
				}
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
			req.setAttribute("seventhStatistics", seventhStatistics);
			req.getRequestDispatcher(
					"/WEB-INF/jsp/administratorStatisticsResult7.jsp").forward(
					req, resp);
		}
		else if (req.getParameter("order").equals("eighth"))
		{			
			sql = "select airlineName, max(c) as maxNumOfPassenger " +
					"from (select airlineCode, count(*) as c " +
					"from reservation join ticket join flight " +
					"where reservation.ticketID = ticket.ticketID " +
					"and ticket.flightNumber = flight.flightNumber " +
					"group bY airlineCode) R natural join airline";
			
			List<EighthStatistic> eighthStatistics = new ArrayList<EighthStatistic>();
			try {
				prepStmt = conn.prepareStatement(sql);
				logger.info("prepStmt: " + prepStmt.toString());
				rs = prepStmt.executeQuery();
				
				while (rs.next())
				{
					EighthStatistic eighthStatistic = new EighthStatistic();
					eighthStatistic.setAirlineName(rs.getString("airlineName"));
					eighthStatistic.setMaxNumOfPassenger(rs.getInt("maxNumOfPassenger"));
					eighthStatistics.add(eighthStatistic);
				}
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
			req.setAttribute("eighthStatistics", eighthStatistics);
			req.getRequestDispatcher(
					"/WEB-INF/jsp/administratorStatisticsResult8.jsp").forward(
					req, resp);
		}
		
	}

}
