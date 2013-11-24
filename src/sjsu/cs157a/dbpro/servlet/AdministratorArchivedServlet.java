package sjsu.cs157a.dbpro.servlet;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import sjsu.cs157a.dbpro.db.DbConnection;

/**
 * Servlet implementation class AdministratorArchivedServlet
 */
@WebServlet("/AdministratorArchivedServlet")
public class AdministratorArchivedServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger
			.getLogger(FlightOperationServlet.class);
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		/*
		String targetTimeStamp = req.getParameter("targetTimeStamp");

		Connection conn = DbConnection.openConnection();

		CallableStatement callStmt = null;
		String sqlError = null;
		String sql = "{call getPastReservationCount (?, @reservationCount)}; select @reservationCount";

		try {
			callStmt = conn.prepareCall(sql);
			callStmt.setString(1, targetTimeStamp);
			// test sql
			logger.info("callStmt: " + callStmt.toString());
			callStmt.execute();
		} catch (SQLException se) {
			se.printStackTrace();
			sqlError = se.getMessage();
		} finally {
			try {
				callStmt.close();
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
		*/		
	}

}
