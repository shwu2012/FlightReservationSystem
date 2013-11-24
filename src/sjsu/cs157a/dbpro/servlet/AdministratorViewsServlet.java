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
import sjsu.cs157a.dbpro.domain.Employee;
import sjsu.cs157a.dbpro.domain.Flight;
import sjsu.cs157a.dbpro.domain.Person;
import sjsu.cs157a.dbpro.domain.Ticket;

/**
 * Servlet implementation class AdministratorViewServlet
 */
public class AdministratorViewsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger
			.getLogger(AdministratorViewsServlet.class);

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Connection conn = DbConnection.openConnection();
		PreparedStatement prepStmt = null;
		String sql = null;
		String sqlError = null;
		ResultSet rs = null;
		
		if (req.getParameter("view").equals("employee"))
		{
			sql = "select userName, lastName, firstName, middleName, age, hourlyPay, birthDate, gender, email, " +
					"phone, street, city, stateProvinceCounty, country, airlineCode from employee";
			
			List<Employee> employees = new ArrayList<Employee>();
			try {
				prepStmt = conn.prepareStatement(sql);
				logger.info("prepStmt: " + prepStmt.toString());
				rs = prepStmt.executeQuery();
				
				while (rs.next())
				{
					Employee employee = new Employee();
					 					
					employee.setUserName(rs.getString("userName"));								
					employee.setLastName(rs.getString("lastName"));
					employee.setFirstName(rs.getString("firstName"));
					employee.setMiddleName(rs.getString("middleName"));
					employee.setAge(rs.getInt("age"));
					employee.setBirthDate(rs.getDate("birthDate"));
					String genderText = rs.getString("gender");
					employee.setGender(genderText == null ? null
							: Person.Gender.valueOf(genderText));
					employee.setEmail(rs.getString("email"));
					employee.setPhone(rs.getString("phone"));
					employee.setStreet(rs.getString("street"));
					employee.setCity(rs.getString("city"));
					employee.setStateProvinceCounty(rs
							.getString("stateProvinceCounty"));
					employee.setCountry(rs.getString("country"));
					employee.setWage(Float.parseFloat(rs.getString("hourlyPay")));
					employee.setAirlineCode(rs.getString("airlineCode"));
															
					employees.add(employee);
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
			req.setAttribute("employees", employees);
			req.getRequestDispatcher(
					"/WEB-INF/jsp/administratorViewEmployeeResult.jsp").forward(
					req, resp);
		}
		else if (req.getParameter("view").equals("flight"))
		{
			sql = "select flightNumber, airlineCode, aircraftModel, departureAirportCode, arrivalAirportCode, " +
					"departureTime, arrivalTime, overnight from flight";
			 
			List<Flight> flights = new ArrayList<Flight>();
			try {
				prepStmt = conn.prepareStatement(sql);
				logger.info("prepStmt: " + prepStmt.toString());
				rs = prepStmt.executeQuery();
				
				while (rs.next())
				{
					Flight flight = new Flight();
					 					
					flight.setFlightNumber(rs.getString("flightNumber"));								
					flight.setAirlineCode(rs.getString("airlineCode"));
					flight.setAircraftModel(rs.getString("aircraftModel"));
					flight.setDepartureAirportCode(rs.getString("departureAirportCode"));
					flight.setArrivalAirportCode(rs.getString("arrivalAirportCode"));
					flight.setDepartureTime(rs.getTime("departureTime"));
					flight.setArrivalTime(rs.getTime("arrivalTime"));
					flight.setOvernight(rs.getBoolean("overnight"));
																	
					flights.add(flight);
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
			req.setAttribute("flights", flights);
			req.getRequestDispatcher(
					"/WEB-INF/jsp/administratorViewFlightResult.jsp").forward(
					req, resp);
		}
		else if (req.getParameter("view").equals("ticket"))
		{
			String flightNumber = req.getParameter("flightNumber");
			sql = "select ticketID, flightNumber, departureDate, arrivalDate, seatClass, availableSeats, " +
					"price from ticket where flightNumber= ?";
						 
			List<Ticket> tickets = new ArrayList<Ticket>();
			
			try {
				prepStmt = conn.prepareStatement(sql);
				prepStmt.setString(1, flightNumber);
				logger.info("prepStmt: " + prepStmt.toString());
				rs = prepStmt.executeQuery();
				
				while (rs.next())
				{
					Ticket ticket = new Ticket();
					
					ticket.setTicketID(rs.getString("ticketID"));
					ticket.setFlightNumber(rs.getString("flightNumber"));								
					ticket.setDepartureDate(rs.getDate("departureDate"));
					ticket.setArrivalDate(rs.getDate("arrivalDate"));					
					ticket.setSeatClass(rs.getString("seatClass"));
					ticket.setAvailableSeats(rs.getInt("availableSeats"));
					ticket.setPrice(rs.getInt("price"));
																	
					tickets.add(ticket);
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
			req.setAttribute("tickets", tickets);
			req.getRequestDispatcher(
					"/WEB-INF/jsp/administratorViewTicketResult.jsp").forward(
					req, resp);
		}
	}

}
