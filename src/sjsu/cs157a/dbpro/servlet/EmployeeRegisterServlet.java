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
 * Servlet implementation class EmployeeRegisterServlet
 */
public class EmployeeRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger
			.getLogger(EmployeeRegisterServlet.class);

    /**
     * @see HttpServlet#HttpServlet()
     */
    public EmployeeRegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String euserName = req.getParameter("euserName");
		String epassword = req.getParameter("epassword");
		String efirstName = req.getParameter("efirstName");
		String emiddleName = req.getParameter("emiddleName");
		String elastName = req.getParameter("elastName");
		Float ewage = Float.parseFloat(req.getParameter("ewage"));
		String eairline = req.getParameter("eairline");
		String ebirthDate = req.getParameter("ebirthDate");
		String egender = req.getParameter("egender");
		String eemail = req.getParameter("eemail");
		String ephone = req.getParameter("ephone");
		String estreet = req.getParameter("estreet");
		String ecity = req.getParameter("ecity");
		String estateProvinceCounty = req.getParameter("estateProvinceCounty");
		String ecountry = req.getParameter("ecountry");				

		Connection conn = DbConnection.openConnection();
		
		Statement stmt = null;
		ResultSet rs = null;
		
		// Calculate passengerID auto increment.
		int employeeCount = 0;
		
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
		String sql1 = "select employeeCount from record";
				

		try {
			prepStmt1 = conn.prepareStatement(sql1);
			logger.info("prepStmt: " + prepStmt1.toString());
			rs = prepStmt1.executeQuery();
			if (rs.next()) {
				employeeCount = rs.getInt("employeeCount");
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
		
		employeeCount++;
		logger.info("emloyeeCount: " + employeeCount);
		int count = employeeCount;
		
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
		String employeeID = "E" + partID + Integer.toString(employeeCount);
				
		// Calculate passenger age	
		Date dateOfBirth = Date.valueOf(ebirthDate);
		int age = calculateAgeByDOB(dateOfBirth);
				
		PreparedStatement prepStmt = null;
		String sqlError = null;
		int sqlErrorCode = 0;
		String sql = "Insert into employee "
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
				+ "?, "
				+ "?"
				+ ")";
		
				
		try {
			prepStmt = conn.prepareStatement(sql);
			prepStmt.setString(1, employeeID);
			prepStmt.setString(2, euserName);
			prepStmt.setString(3, epassword);
			prepStmt.setString(4, elastName);
			prepStmt.setString(5, efirstName);
			prepStmt.setString(6, emiddleName);
			prepStmt.setString(7, egender);
			prepStmt.setInt(8, age);
			// a date in in the format "yyyy-mm-dd"
			prepStmt.setDate(9, dateOfBirth);
			prepStmt.setFloat(10, ewage);
			prepStmt.setString(11, eemail);
			prepStmt.setString(12, ephone);
			prepStmt.setString(13, estreet);
			prepStmt.setString(14, ecity);
			prepStmt.setString(15, estateProvinceCounty);
			prepStmt.setString(16, ecountry);
			prepStmt.setString(17, eairline);
			// test sql
			logger.info("prepStmt: " + prepStmt.toString());
			prepStmt.executeUpdate();
		} catch (SQLException se) {
			se.printStackTrace();
			sqlError = se.getMessage();
			sqlErrorCode = se.getErrorCode();
		} finally {
			try {
				prepStmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		DbConnection.closeConnection(conn);
		logger.info("Username: " + euserName);

		if (sqlError == null) {
			req.getSession().setAttribute("username", euserName);
			// Redirect to dashboard.
			resp.sendRedirect("employeedashboard?show=viewEmployeeInfo");
		} else {
			req.setAttribute("sqlError", Helper.parseSqlError(sqlError, sqlErrorCode, "employee"));
			req.setAttribute("type", "registerEmployee");
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
