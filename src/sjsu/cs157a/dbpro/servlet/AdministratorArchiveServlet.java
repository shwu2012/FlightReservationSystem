package sjsu.cs157a.dbpro.servlet;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import sjsu.cs157a.dbpro.db.DbConnection;

/**
 * Servlet implementation class AdministratorArchivedServlet
 */
public class AdministratorArchiveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger
			.getLogger(FlightOperationServlet.class);
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String archiveDate = req.getParameter("archiveDate");
		int threshold = Integer.parseInt(req.getParameter("threshold"));

		Connection conn = DbConnection.openConnection();

		CallableStatement callStmt = null;
		String sqlError = null;
		int sqlErrorCode = 0;
		String countSql = "{call getPastReservationCount(?, ?)}";
		String insertSql = "{call insertArchivedReservation(?)}";
		String deleteSql = "{call deleteReservation(?)}";
		String message = null;

		Timestamp archiveTimeStamp = Timestamp.valueOf(archiveDate + " 00:00:00");
		try {
			conn.setAutoCommit(false);
			callStmt = conn.prepareCall(countSql);
			callStmt.setTimestamp(1, archiveTimeStamp);
			callStmt.registerOutParameter(2, Types.INTEGER);
			// test sql
			logger.info("callStmt: " + callStmt.toString());
			callStmt.execute();
			
			if (callStmt.getInt(2) > threshold){
				// call insert procedure
				callStmt = conn.prepareCall(insertSql);
				callStmt.setTimestamp(1, archiveTimeStamp);
				callStmt.execute();
				// test sql
				logger.info("callStmt: " + callStmt.toString());
				
				// call delete procedure
				callStmt = conn.prepareCall(deleteSql);
				callStmt.setTimestamp(1, archiveTimeStamp);
				callStmt.execute();
				// test sql
				logger.info("callStmt: " + callStmt.toString());				
				
				callStmt.execute();				
			} else {
				message = "No need to archive since the number of satisfying tuples don't reach the threshold.";
			}
			conn.commit();
		} catch (SQLException se) {
			se.printStackTrace();
			sqlError = se.getMessage();
			sqlErrorCode = se.getErrorCode();
			if (conn != null) {
				try {
					conn.rollback();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		} finally {
			try {
				callStmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		DbConnection.closeConnection(conn);
		req.setAttribute("sqlError", sqlError);
		req.setAttribute("message", message);
		req.getRequestDispatcher(
				"/WEB-INF/jsp/administratorArchiveResult.jsp").forward(
				req, resp);	
	}

}
