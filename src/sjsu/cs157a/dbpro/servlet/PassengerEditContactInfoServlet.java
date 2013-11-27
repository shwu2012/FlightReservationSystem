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
 * Servlet implementation class EditContactInfoServlet
 */
public class PassengerEditContactInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger
			.getLogger(PassengerEditContactInfoServlet.class);

    /**
     * @see HttpServlet#HttpServlet()
     */
    public PassengerEditContactInfoServlet() 
    {
        super();
        // TODO Auto-generated constructor stub
    }

	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub
		
					
			String puserName = (String) req.getSession()
					.getAttribute("username");
			
			String ppassword = req.getParameter("ppassword");
			String pfirstName = req.getParameter("pfirstname");
			String pmiddleName = req.getParameter("pmiddlename");
			String plastName = req.getParameter("plastname");
			String pemail = req.getParameter("pemail");
			String pphone = req.getParameter("pphone");
			String pstreet = req.getParameter("pstreet");
			String pcity = req.getParameter("pcity");
			String pstateProvinceCounty = req.getParameter("pstate");
			String pcountry = req.getParameter("pcountry");
			
			/*logger.info("Username: " + puserName);
			logger.info("pfirstName: " + pfirstName);
			logger.info("pmiddleName: " + pmiddleName);
			logger.info("plastName: " + plastName);
			logger.info("pemail: " + pemail);
			logger.info("pphone: " + pphone);
			logger.info("pstreet: " + pstreet);
			logger.info("pstateProvinceCounty: " + pstateProvinceCounty);
			logger.info("pcountry: " + pcountry);*/
			
			Connection conn = DbConnection.openConnection();

			PreparedStatement prepStmt = null;
			
			String sqlError = null;
			int sqlErrorCode = 0;
			String sql = "Update passenger "
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
				prepStmt.setString(1, ppassword);
				prepStmt.setString(2, pfirstName);
				prepStmt.setString(3, pmiddleName);
				prepStmt.setString(4, plastName);
				prepStmt.setString(5, pemail);
				prepStmt.setString(6, pphone);
				prepStmt.setString(7, pstreet);
				prepStmt.setString(8, pcity);
				prepStmt.setString(9, pstateProvinceCounty);
				prepStmt.setString(10, pcountry);
				prepStmt.setString(11, puserName);
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
			logger.info("Username: " + puserName);
			req.setAttribute("sqlError", Helper.parseSqlError(sqlError, sqlErrorCode, "passenger"));
			req.getRequestDispatcher("/WEB-INF/jsp/passengerEditContactInfo.jsp").forward(req, resp);
	}

}
