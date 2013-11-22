package sjsu.cs157a.dbpro.servlet;

import java.io.IOException;
import java.sql.Connection;
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
import sjsu.cs157a.dbpro.domain.Passenger;
import sjsu.cs157a.dbpro.domain.Person;
import sjsu.cs157a.dbpro.domain.Reservation;

/**
 * Servlet implementation class PassengerDashboardServlet
 */
public class PassengerDashboardServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger
			.getLogger(PassengerDashboardServlet.class);

	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		if (req.getParameter("show").equals("viewCustomerInfo")) {
			String username = (String) req.getSession()
					.getAttribute("username");

			Connection conn = DbConnection.openConnection();

			ResultSet rs = null;
			Passenger passenger = new Passenger();

			PreparedStatement prepStmt = null;
			String sql = "select firstName, middleName, lastName, age, birthDate, gender, email, phone, street, city, stateProvinceCounty, country from passenger "
					+ "where username = ?";

			try {
				prepStmt = conn.prepareStatement(sql);
				prepStmt.setString(1, username);
				logger.info("prepStmt: " + prepStmt.toString());
				rs = prepStmt.executeQuery();
				if (rs.next()) {
					passenger.setLastName(rs.getString("lastName"));
					passenger.setFirstName(rs.getString("firstName"));
					passenger.setMiddleName(rs.getString("middleName"));
					passenger.setAge(rs.getInt("age"));
					passenger.setBirthDate(rs.getDate("birthDate"));
					String genderText = rs.getString("gender");
					passenger.setGender(genderText == null ? null
							: Person.Gender.valueOf(genderText));
					passenger.setEmail(rs.getString("email"));
					passenger.setPhone(rs.getString("phone"));
					passenger.setStreet(rs.getString("street"));
					passenger.setCity(rs.getString("city"));
					passenger.setStateProvinceCounty(rs
							.getString("stateProvinceCounty"));
					passenger.setCountry(rs.getString("country"));
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
			req.setAttribute("passenger", passenger);
		}
		else if (req.getParameter("show").equals("editPassengerInfo")){
			// TODO
		}
		else if (req.getParameter("show").equals("makeReservation")){
			// No operation
		}
		else if (req.getParameter("show").equals("cancelReservation")){
			// TODO
		}
		else if (req.getParameter("show").equals("viewReservations")){
			// TODO
			String username = (String) req.getSession()
					.getAttribute("username");

			String passengerID = null;
			
			Connection conn = DbConnection.openConnection();

			ResultSet rs = null;
			
			PreparedStatement prepStmt = null;
			String sql = "select passengerID from passenger "
					+ "where username = ?";

			try {
				prepStmt = conn.prepareStatement(sql);
				prepStmt.setString(1, username);
				logger.info("prepStmt: " + prepStmt.toString());
				rs = prepStmt.executeQuery();
				rs.next();				
				passengerID = rs.getString("passengerID");
				}
			 catch (SQLException se) {
				se.printStackTrace();
			} finally {
				try {
					prepStmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			List<Reservation> reservations = new ArrayList<Reservation>();
			String sql2 = "select reservationID, ticket.flightNumber, airlineCode, departureAirportCode, departureDate, departureTime, arrivalAirportCode, arrivalDate, arrivalTime, seatClass, price"
					+ " from flight join ticket join reservation where "
					+ "passengerID = ? and ticket.ticketID = reservation.ticketID and flight.flightNumber = ticket.flightNUmber";

			try {
				prepStmt = conn.prepareStatement(sql2);
				prepStmt.setString(1, passengerID);
				//prepStmt.setString(2, ticketID);
				// test sql
				logger.info("prepStmt: " + prepStmt.toString());
				rs = prepStmt.executeQuery();
				while (rs.next())
				{
					Reservation reservation = new Reservation();

					reservation.setReservationID(rs.getString("reservationID"));
					reservation.setFlightNumber(rs.getString("flightNumber"));
					reservation.setAirlineName(rs.getString("airlineCode"));
					reservation.setDepartureAirportCode(rs
							.getString("departureAirportCode"));
					reservation.setDepartureDate(rs.getDate("departureDate"));
					reservation.setDepartureTime(rs.getTime("departureTime"));
					reservation.setArrivalAirportCode(rs
							.getString("arrivalAirportCode"));
					reservation.setArrivalDate(rs.getDate("arrivalDate"));
					reservation.setArrivalTime(rs.getTime("arrivalTime"));
					reservation.setSeatClass(rs.getString("seatClass"));
					reservation.setPrice(rs.getFloat("price"));
					reservations.add(reservation);
				}
			}
			 catch (SQLException se) {
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
			req.setAttribute("reservations", reservations);			
		}
		

		// Forward to view (i.e. JSP pages).
		logger.info("forward to passengerDashboard.jsp");
		req.getRequestDispatcher("/WEB-INF/jsp/passengerDashboard.jsp")
				.forward(req, resp);
	}

}
