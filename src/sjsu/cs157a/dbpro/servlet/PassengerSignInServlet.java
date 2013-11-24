package sjsu.cs157a.dbpro.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import sjsu.cs157a.dbpro.db.DbConnection;

/**
 * Servlet implementation class SignInServlet
 */
public class PassengerSignInServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger
			.getLogger(PassengerSignInServlet.class);

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		String pusername = req.getParameter("pusername");
		String ppassword = req.getParameter("ppassword");

		Connection conn = DbConnection.openConnection();
		PreparedStatement prepStmt = null;
		ResultSet rs = null;
		int count = 0;
		String sql = "select count(*) "
				+ "from passenger where "
				+ "username = ? and "
				+ "pwd = ?";		
		try {
			prepStmt = conn.prepareStatement(sql);
			prepStmt.setString(1, pusername);
			prepStmt.setString(2, ppassword);
			rs = prepStmt.executeQuery();
			// test sql
			logger.info("prepStmt: " + prepStmt.toString());
			if (rs.next()) {
				count = rs.getInt("count(*)");
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

		if (count == 1) {
			logger.info("set username: " + pusername);
			req.getSession().setAttribute("username", pusername);
			// Redirect to dashboard.
			resp.sendRedirect("passengerdashboard?show=makeReservation");
		} else {
			logger.info(String.format("invalid username: %s, password: %s",
					pusername, ppassword));
			req.setAttribute("passengerError", "Invalid username/password combination.");
			req.setAttribute("type", "passenger");
			req.getRequestDispatcher("/WEB-INF/jsp/signin.jsp").forward(req, resp);
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.getRequestDispatcher("/WEB-INF/jsp/signin.jsp").forward(req, resp);
	}

}
