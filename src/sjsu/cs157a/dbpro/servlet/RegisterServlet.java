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

/**
 * Servlet implementation class RegisterServlet
 */
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final Logger logger = Logger.getLogger(RegisterServlet.class);	
	
	public static int baseNumber = 0; 
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

		DbConnection dbc = new DbConnection();
		Connection conn = dbc.openConnection();
		
		Statement stmt = null;
		ResultSet rs = null;
		
		// Calculate passengerID auto increment.
		int passengerCount = 0;
		try {
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
		}
		
		// Calculate passenger age	
		Date dateOfBirth = Date.valueOf(pbirthDate);
		int age = calculateAgeByDOB(dateOfBirth);
				
		PreparedStatement prepStmt = null;
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
				+ "?, "
				+ "?"
				+ ")";
		
		try {
			prepStmt = conn.prepareStatement(sql);
			prepStmt.setString(1, "P" + Integer.toString(passengerCount));
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
			prepStmt.setInt(16, 0);
			// test sql
			logger.info("prepStmt: " + prepStmt.toString());
			prepStmt.executeUpdate();
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
		logger.info("Username: " + puserName);

		req.getSession().setAttribute("username", puserName);
		// Redirect to dashboard.
		resp.sendRedirect("passengerdashboard?show=viewCustomerInfo");	
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
