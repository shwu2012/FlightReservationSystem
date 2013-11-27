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
import sjsu.cs157a.dbpro.domain.Helper;

/**
 * Servlet implementation class EmployeeEditContactInfoServlet
 */
public class EmployeeEditContactInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger
			.getLogger(PassengerEditContactInfoServlet.class);   

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub
		
					
			String euserName = (String) req.getSession()
					.getAttribute("username");
			
			String epassword = req.getParameter("epassword");
			String efirstName = req.getParameter("efirstname");
			String emiddleName = req.getParameter("emiddlename");
			String elastName = req.getParameter("elastname");
			String eemail = req.getParameter("eemail");
			String ephone = req.getParameter("ephone");
			String estreet = req.getParameter("estreet");
			String ecity = req.getParameter("ecity");
			String estateProvinceCounty = req.getParameter("estate");
			String ecountry = req.getParameter("ecountry");
			
			/*logger.info("Username: " + euserName);
			logger.info("efirstName: " + efirstName);
			logger.info("emiddleName: " + emiddleName);
			logger.info("elastName: " + elastName);
			logger.info("eemail: " + eemail);
			logger.info("ephone: " + ephone);
			logger.info("estreet: " + estreet);
			logger.info("estateProvinceCounty: " + estateProvinceCounty);
			logger.info("ecountry: " + ecountry);*/
			
			Connection conn = DbConnection.openConnection();

			PreparedStatement prepStmt = null;
			
			//logger.info("build up connection");
			String sqlError = null;
			int sqlErrorCode = 0;
			String sql = "Update employee "
					+ "set pwd = ?, "
					+ "firstName = ?, "
					+ "middleName = ?, "
					+ "lastName = ?, "
					+ "email = ?, "
					+ "phone = ?, "
					+ "street = ?, "
					+ "city = ?, "
					+ "stateProvinceCounty = ?, "
					+ "country = ? "
					+ "where username = ?";
			
			//logger.info("write update sql");
			
			try 
			{
				prepStmt = conn.prepareStatement(sql);
				prepStmt.setString(1, epassword);
				prepStmt.setString(2, efirstName);
				prepStmt.setString(3, emiddleName);
				prepStmt.setString(4, elastName);
				prepStmt.setString(5, eemail);
				prepStmt.setString(6, ephone);
				prepStmt.setString(7, estreet);
				prepStmt.setString(8, ecity);
				prepStmt.setString(9, estateProvinceCounty);
				prepStmt.setString(10, ecountry);
				prepStmt.setString(11, euserName);
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
			req.setAttribute("sqlError", Helper.parseSqlError(sqlError, sqlErrorCode, "employee"));
			req.getRequestDispatcher("/WEB-INF/jsp/employeeEditContactInfo.jsp").forward(req, resp);
	}

}
