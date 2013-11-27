package sjsu.cs157a.dbpro.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import sjsu.cs157a.dbpro.db.DbConnection;
import sjsu.cs157a.dbpro.domain.Helper;

/**
 * Servlet implementation class RegisterServlet
 */
public class PassengerRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final Logger logger = Logger
			.getLogger(PassengerRegisterServlet.class);	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String puserName = req.getParameter("puserName");
		String ppassword = req.getParameter("ppassword");
		String pfirstName = req.getParameter("pfirstName");
		String pmiddleName = req.getParameter("pmiddleName");
		String plastName = req.getParameter("plastName");
		String pbirthDate = req.getParameter("pbirthDate");
		String pgender = req.getParameter("pgender");
		String pemail = req.getParameter("pemail");
		String pphone = req.getParameter("pphone");
		String pstreet = req.getParameter("pstreet");
		String pcity = req.getParameter("pcity");
		String pstateProvinceCounty = req.getParameter("pstateProvinceCounty");
		String pcountry = req.getParameter("pcountry");				

		Connection conn = DbConnection.openConnection();
		
		Statement stmt = null;
		ResultSet rs = null;
		
		// Calculate passengerID auto increment.
		int passengerCount = 0;
		logger.info("passengerCount: " + passengerCount);
		
		/*try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select count(*) from passenger");
			while (rs.next()) {
				passengerCount = rs.getInt("count(*)");
			}			
		} catch (SQLException e) {
			// TODO 
		} finally {
			try {
				stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}*/
		
		
		PreparedStatement prepStmt1 = null;
		String sql1 = "select passengerCount from record";
				

		try {
			prepStmt1 = conn.prepareStatement(sql1);
			logger.info("prepStmt: " + prepStmt1.toString());
			rs = prepStmt1.executeQuery();
			if (rs.next()) {
				passengerCount = rs.getInt("passengerCount");
			}
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			try {
				prepStmt1.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		passengerCount++;
		logger.info("passengerCount: " + passengerCount);
		int count = passengerCount;
		
		int magCount = 0;
		String partID = "";
		while (count > 0)
		{
			count /= 10;
			magCount++;			
		}
		for (int i = 0; i < 9 - magCount; i++)
		{
			partID += "0";
		}
		logger.info("partID: " + partID);
		String passengerID = "P" + partID + Integer.toString(passengerCount);
				
		// Calculate passenger age	
		Date dateOfBirth = Date.valueOf(pbirthDate);
		int age = calculateAgeByDOB(dateOfBirth);
				
		PreparedStatement prepStmt = null;
		String sqlError = null;
		int sqlErrorCode = 0;
		String sql = "Insert into passenger "
				+ "values ("
				+ "?, "
				+ "?, "
				+ "?, "
				+ "?, "
				+ "?, "
				+ "?, "
				+ "?, "
				+ "?, "
				+ "?, "
				+ "?, "
				+ "?, "
				+ "?, "
				+ "?, "
				+ "?, "
				+ "?"
				+ ")";
		
		try {
			prepStmt = conn.prepareStatement(sql);
			prepStmt.setString(1, passengerID);
			prepStmt.setString(2, puserName);
			prepStmt.setString(3, ppassword);
			prepStmt.setString(4, plastName);
			prepStmt.setString(5, pfirstName);
			prepStmt.setString(6, pmiddleName);
			prepStmt.setInt(7, age);
			// a date in in the format "yyyy-mm-dd"
			prepStmt.setDate(8, dateOfBirth);
			prepStmt.setString(9, pgender);
			prepStmt.setString(10, pemail);
			prepStmt.setString(11, pphone);
			prepStmt.setString(12, pstreet);
			prepStmt.setString(13, pcity);
			prepStmt.setString(14, pstateProvinceCounty);
			prepStmt.setString(15, pcountry);
			// test sql
			logger.info("prepStmt: " + prepStmt.toString());
			prepStmt.executeUpdate();
		} catch (SQLException se) {
			se.printStackTrace();
			sqlError = se.getMessage();
			sqlErrorCode = se.getErrorCode();
			logger.info("sqlError: " + sqlError);
			logger.info("sqlErrorCode: " + sqlErrorCode);
		} finally {
			try {
				prepStmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		DbConnection.closeConnection(conn);
		logger.info("Username: " + puserName);

		if (sqlError == null) {
			req.getSession().setAttribute("username", puserName);
			// Redirect to dashboard.
			resp.sendRedirect("passengerdashboard?show=viewCustomerInfo");
		} else {
			req.setAttribute("sqlError", Helper.parseSqlError(sqlError, sqlErrorCode, "passenger"));
			req.setAttribute("type", "registerPassenger");
			req.getRequestDispatcher("/WEB-INF/jsp/signin.jsp").forward(req,
					resp);
		}

	}

	private static int calculateAgeByDOB(Date dateOfBirth) {
		Calendar dob = Calendar.getInstance();
		dob.setTime(dateOfBirth);
		Calendar today = Calendar.getInstance();
		int age = today.get(Calendar.YEAR) - dob.get(Calendar.YEAR);
		if (today.get(Calendar.DAY_OF_YEAR) <= dob.get(Calendar.DAY_OF_YEAR))
			age--;
		return age;
	}

}
