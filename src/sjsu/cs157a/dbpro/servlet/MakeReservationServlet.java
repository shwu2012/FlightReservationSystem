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
import sjsu.cs157a.dbpro.domain.Reservation;

/**
 * Servlet implementation class MakeReservationServlet
 */
public class MakeReservationServlet extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger
			.getLogger(MakeReservationServlet.class);

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException
	{
		// TODO Auto-generated method stub

		String reservationType = req.getParameter("reservationType");

		if (reservationType.equals("oneWay"))
		{
			String ticketID = req.getParameter("flightSelected");
			String puserName = (String) req.getSession().getAttribute(
					"username");

			Connection conn = DbConnection.openConnection();
			String sqlError = null;
			int reservationCount = 0;
			PreparedStatement prepStmt1 = null;
			ResultSet rs = null;
			String sql1 = "select reservationCount from record";

			try
			{
				prepStmt1 = conn.prepareStatement(sql1);
				logger.info("prepStmt: " + prepStmt1.toString());
				rs = prepStmt1.executeQuery();
				if (rs.next())
				{
					reservationCount = rs.getInt("reservationCount");
				}
			}
			catch (SQLException se)
			{
				se.printStackTrace();
			}
			finally
			{
				try
				{
					prepStmt1.close();
				}
				catch (SQLException e)
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			reservationCount++;
			logger.info("reservationCount: " + reservationCount);
			int count = reservationCount;

			int magCount = 0;
			String partID = "";
			while (count > 0)
			{
				count /= 10;
				magCount++;
			}
			for (int i = 0; i < 11 - magCount; i++)
			{
				partID += "0";
			}
			logger.info("partID: " + partID);
			String reservationID = "R" + partID
					+ Integer.toString(reservationCount);

			PreparedStatement prepStmt = null;
			String sql = "insert into reservation " + "select ?, passengerID, ?, null"
					+ " from passenger where username = ?";

			try
			{
				prepStmt = conn.prepareStatement(sql);
				prepStmt.setString(1, reservationID);
				prepStmt.setString(2, ticketID);
				prepStmt.setString(3, puserName);

				logger.info("prepStmt: " + prepStmt.toString());
				prepStmt.executeUpdate();
			}
			catch (SQLException se)
			{
				se.printStackTrace();
				sqlError = se.getMessage();
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

			String sql2 = "select ticket.flightNumber, airlineCode, " +
					"departureAirportCode, departureDate, departureTime, " +
					"arrivalAirportCode, arrivalDate, arrivalTime, seatClass, price"
					+ " from flight join ticket join reservation where "
					+ "reservationID = ? and ticket.ticketID = reservation.ticketID " +
					"and flight.flightNumber = ticket.flightNUmber";

			List<Reservation> reservations = new ArrayList<Reservation>();
			
			try
			{
				prepStmt = conn.prepareStatement(sql2);
				prepStmt.setString(1, reservationID);
				//prepStmt.setString(2, ticketID);
				// test sql
				logger.info("prepStmt: " + prepStmt.toString());
				rs = prepStmt.executeQuery();
				while (rs.next())
				{
					Reservation reservation = new Reservation();

					reservation.setReservationID(reservationID);
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
			catch (SQLException se)
			{
				se.printStackTrace();
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
			logger.info("tickets count: " + reservations.size());
			req.setAttribute("reservations", reservations);

			// Forward to view (i.e. JSP pages).
			req.getRequestDispatcher("/WEB-INF/jsp/oneWayReservationResult.jsp")
					.forward(req, resp);

		}
		else
		{
			String reservationID1 = null;
			String reservationID2 = null;

			String ticketID1 = req.getParameter("departFlightSelected");
			String ticketID2 = req.getParameter("returnFlightSelected");

			String puserName = (String) req.getSession().getAttribute(
					"username");

			Connection conn = DbConnection.openConnection();
			String sqlError = null;

			PreparedStatement prepStmt1 = null;
			ResultSet rs = null;

			List<Reservation> reservations = new ArrayList<Reservation>();

			for (int round = 0; round < 2; round++)
			{
				int reservationCount = 0;
				String sql1 = "select reservationCount from record";

				try
				{
					prepStmt1 = conn.prepareStatement(sql1);
					logger.info("prepStmt: " + prepStmt1.toString());
					rs = prepStmt1.executeQuery();
					if (rs.next())
					{
						reservationCount = rs.getInt("reservationCount");
					}
				}
				catch (SQLException se)
				{
					se.printStackTrace();
				}
				finally
				{
					try
					{
						prepStmt1.close();
					}
					catch (SQLException e)
					{
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}

				reservationCount++;
				logger.info("reservationCount: " + reservationCount);
				int count = reservationCount;

				int magCount = 0;
				String partID = "";
				while (count > 0)
				{
					count /= 10;
					magCount++;
				}
				for (int i = 0; i < 11 - magCount; i++)
				{
					partID += "0";
				}
				logger.info("partID: " + partID);
				if (round == 0)
				{
					reservationID1 = "R" + partID
							+ Integer.toString(reservationCount);
				}
				else
				{
					reservationID2 = "R" + partID
							+ Integer.toString(reservationCount);
				}

				PreparedStatement prepStmt = null;
				String sql = "insert into reservation"
						+ " select ?, passengerID, ?, null"
						+ " from passenger where username = ?";

				try
				{
					prepStmt = conn.prepareStatement(sql);

					if (round == 0)
					{
						prepStmt.setString(1, reservationID1);
						prepStmt.setString(2, ticketID1);
					}
					else
					{
						prepStmt.setString(1, reservationID2);
						prepStmt.setString(2, ticketID2);
					}
					prepStmt.setString(3, puserName);

					logger.info("prepStmt: " + prepStmt.toString());
					prepStmt.executeUpdate();
				}
				catch (SQLException se)
				{
					se.printStackTrace();
					sqlError = se.getMessage();
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

				String sql2 = "select ticket.flightNumber, airlineCode, departureAirportCode, departureDate, departureTime, arrivalAirportCode, arrivalDate, arrivalTime, seatClass, price"
						+ " from flight join ticket join reservation where "
						+ "reservationID = ? and ticket.ticketID = reservation.ticketID and flight.flightNumber = ticket.flightNUmber";

				try
				{
					prepStmt = conn.prepareStatement(sql2);
					if (round == 0)
					{
						prepStmt.setString(1, reservationID1);
						//prepStmt.setString(2, ticketID1);
					}
					else
					{
						prepStmt.setString(1, reservationID2);
						//prepStmt.setString(2, ticketID2);
					}
					// test sql
					logger.info("prepStmt: " + prepStmt.toString());
					rs = prepStmt.executeQuery();
					while (rs.next())
					{
						Reservation reservation = new Reservation();
						if (round == 0)
						{
							reservation.setReservationID(reservationID1);
						}
						else
						{
							reservation.setReservationID(reservationID2);
						}
						reservation.setFlightNumber(rs
								.getString("flightNumber"));
						reservation.setAirlineName(rs.getString("airlineCode"));
						reservation.setDepartureAirportCode(rs
								.getString("departureAirportCode"));
						reservation.setDepartureDate(rs
								.getDate("departureDate"));
						reservation.setDepartureTime(rs
								.getTime("departureTime"));
						reservation.setArrivalAirportCode(rs
								.getString("arrivalAirportCode"));
						reservation.setArrivalDate(rs.getDate("arrivalDate"));
						reservation.setArrivalTime(rs.getTime("arrivalTime"));
						reservation.setSeatClass(rs.getString("seatClass"));
						reservation.setPrice(rs.getFloat("price"));
						reservations.add(reservation);
					}
				}
				catch (SQLException se)
				{
					se.printStackTrace();
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
			}

			DbConnection.closeConnection(conn);
			logger.info("reservatios count: " + reservations.size());
			req.setAttribute("reservations", reservations);

			// Forward to view (i.e. JSP pages).
			req.getRequestDispatcher(
					"/WEB-INF/jsp/roundtripReservationResult.jsp").forward(req,
					resp);

		}

	}

}
