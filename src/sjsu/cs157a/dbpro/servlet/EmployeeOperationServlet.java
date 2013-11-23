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
 * Servlet implementation class EmployeeOperationServlet
 */
public class EmployeeOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger
			.getLogger(FlightOperationServlet.class);

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getParameter("op").equals("update")) {
			String hourlyPay = req.getParameter("hourlyPay");
			String employeeUsername = req.getParameter("employeeUsername");
			
			Connection conn = DbConnection.openConnection();

			PreparedStatement prepStmt = null;
			String sqlError = null;
			String sql = "update employee set hourlyPay = ? where username = ?";

			try {
				prepStmt = conn.prepareStatement(sql);
				prepStmt.setString(1, hourlyPay);
				prepStmt.setString(2, employeeUsername);
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
			String employeeUsername = req.getParameter("employeeUsername");
			
			Connection conn = DbConnection.openConnection();

			PreparedStatement prepStmt = null;
			String sqlError = null;
			String sql = "delete from employee where username = ?";

			try {
				prepStmt = conn.prepareStatement(sql);
				prepStmt.setString(1, employeeUsername);
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
