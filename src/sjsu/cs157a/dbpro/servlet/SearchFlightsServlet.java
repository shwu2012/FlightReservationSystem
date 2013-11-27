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
import sjsu.cs157a.dbpro.domain.Ticket;

public class SearchFlightsServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger
			.getLogger(SearchFlightsServlet.class);

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String reservationType = req.getParameter("reservationType");
		String departureCity = null;
		String arrivalCity = null;
		String departDate = null;
		String seatClass = null;
		String returnDate = null;
		if (reservationType.equals("roundTrip")) {
			returnDate = req.getParameter("returnDate2");
			departureCity = req.getParameter("departureCity2");
			arrivalCity = req.getParameter("arrivalCity2");
			departDate = req.getParameter("departDate2");
			seatClass = req.getParameter("seatClass2");			
		} else {
			departureCity = req.getParameter("departureCity");
			arrivalCity = req.getParameter("arrivalCity");
			departDate = req.getParameter("departDate");
			seatClass = req.getParameter("seatClass");				
		}

		Connection conn = DbConnection.openConnection();
		PreparedStatement prepStmt = null;
		String sql = "select airlineName, flightNumber, departureAirportCode, arrivalAirportCode, departureTime, arrivalTime, price, availableSeats, ticketID "
				+ "from flight natural join ticket natural join airline where "
				+ "departureAirportCode = (select airportCode from airport where city = ?) and "
				+ "arrivalAirportCode = (select airportCode from airport where city = ?) and "
				+ "ticket.departureDate = ? and "
				+ "ticket.seatClass = ?";
		ResultSet rs = null;
		List<Ticket> tickets = new ArrayList<Ticket>();
		String departureAirportCode = null;
		String arrivalAirportCode = null;

		List<Ticket> returnTickets = null;
		if (reservationType.equals("roundTrip")) {
			returnTickets = new ArrayList<Ticket>();
		}

		try {
			prepStmt = conn.prepareStatement(sql);
			prepStmt.setString(1, departureCity);
			prepStmt.setString(2, arrivalCity);
			// a date in in the format "yyyy-mm-dd"
			prepStmt.setDate(3, Date.valueOf(departDate));
			prepStmt.setString(4, seatClass);
			// test sql
			logger.info("prepStmt: " + prepStmt.toString());
			rs = prepStmt.executeQuery();
			while (rs.next()){
				Ticket ticket = new Ticket();
				ticket.setTicketID(rs.getString("ticketID"));
				ticket.setAirlineName(rs.getString("airlineName"));
				ticket.setFlightNumber(rs.getString("flightNumber"));
				ticket.setDepartureTime(rs.getTime("departureTime"));
				ticket.setArrivalTime(rs.getTime("arrivalTime"));
				ticket.setPrice(rs.getFloat("price"));
				ticket.setAvailableSeats(rs.getInt("availableSeats"));
				tickets.add(ticket);
				departureAirportCode = rs.getString("departureAirportCode");
				arrivalAirportCode = rs.getString("arrivalAirportCode");
			}

			if (reservationType.equals("roundTrip")) {
				prepStmt = conn.prepareStatement(sql);
				prepStmt.setString(1, arrivalCity);
				prepStmt.setString(2, departureCity);
				// a date in in the format "yyyy-mm-dd"
				prepStmt.setDate(3, Date.valueOf(returnDate));
				prepStmt.setString(4, seatClass);
				// test sql
				logger.info("prepStmt: " + prepStmt.toString());
				rs = prepStmt.executeQuery();
				while (rs.next()){
					Ticket ticket = new Ticket();
					ticket.setTicketID(rs.getString("ticketID"));
					ticket.setAirlineName(rs.getString("airlineName"));
					ticket.setFlightNumber(rs.getString("flightNumber"));
					ticket.setDepartureTime(rs.getTime("departureTime"));
					ticket.setArrivalTime(rs.getTime("arrivalTime"));
					ticket.setPrice(rs.getFloat("price"));
					ticket.setAvailableSeats(rs.getInt("availableSeats"));
					returnTickets.add(ticket);
				}
			}
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			try {
				prepStmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		DbConnection.closeConnection(conn);
		logger.info("tickets count: " + tickets.size());
		req.setAttribute("departureCity", departureCity);
		req.setAttribute("arrivalCity", arrivalCity);
		req.setAttribute("seatClass", seatClass);
		req.setAttribute("departDate", Date.valueOf(departDate));
		req.setAttribute("departureAirportCode", departureAirportCode);
		req.setAttribute("arrivalAirportCode", arrivalAirportCode);
		req.setAttribute("tickets", tickets);

		if (reservationType.equals("roundTrip")) {
			logger.info("tickets count: " + returnTickets.size());
			req.setAttribute("returnDate", Date.valueOf(returnDate));
			req.setAttribute("returnTickets", returnTickets);
		}

		// Forward to view (i.e. JSP pages).
		if (reservationType.equals("roundTrip")) {
			req.getRequestDispatcher("/WEB-INF/jsp/roundTripSearchResult.jsp").forward(req, resp);
		} else {
			req.getRequestDispatcher("/WEB-INF/jsp/oneWaySearchResult.jsp").forward(req, resp);
		}
		
	}

}
