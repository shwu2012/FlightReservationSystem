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

import sjsu.cs157a.dbpro.db.DbConnection;
import sjsu.cs157a.dbpro.domain.Ticket;

public class RegisterServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String departureAirportCode = req.getParameter("departureAirportCode");
		String arrivalAirportCode = req.getParameter("arrivalAirportCode");
		String departureDate = req.getParameter("departureDate");
		String seatClass = req.getParameter("seatClass");

		DbConnection dbc = new DbConnection();
		Connection conn = dbc.openConnection();
		PreparedStatement prepStmt = null;
		String sql = "select flight.flightNumber, airlineCode, price "
				+ "from flight, ticket where "
				+ "flight.flightNumber = ticket.flightNumber and "
				+ "ticket.departureDate = ? and "
				+ "ticket.seatClass = ? and "
				+ "flight.departureAirportCode = ? and "
				+ "flight.arrivalAirportCode = ?";
		ResultSet rs = null;
		List<Ticket> tickets = new ArrayList<Ticket>();
		
		try {
			prepStmt = conn.prepareStatement(sql);
			// a date in in the format "yyyy-mm-dd"
			prepStmt.setDate(1, Date.valueOf(departureDate));
			prepStmt.setString(2, seatClass);
			prepStmt.setString(3, departureAirportCode);
			prepStmt.setString(4, arrivalAirportCode);
			// test sql
			System.out.println("prepStmt: " + prepStmt.toString());
			rs = prepStmt.executeQuery();
			while (rs.next()){
				Ticket ticket = new Ticket();
				ticket.setDepartureDate(Date.valueOf(departureDate));
				ticket.setDepartureAirportCode(departureAirportCode);
				ticket.setArrivalAirportCode(arrivalAirportCode);
				ticket.setSeatClass(seatClass);
				ticket.setAirlineCode(rs.getString("airlineCode"));
				ticket.setFlightNumber(rs.getString("flightNumber"));
				ticket.setPrice(rs.getFloat("price"));
				tickets.add(ticket);
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

		dbc.closeConnection(conn);
		System.out.println("tickets: " + tickets.size());
		req.setAttribute("tickets", tickets);
		req.setAttribute("msg", "this is first message");

		// Forward to view (i.e. JSP pages).
		req.getRequestDispatcher("/WEB-INF/jsp/ticket_list.jsp").forward(req, resp);
	}

}
