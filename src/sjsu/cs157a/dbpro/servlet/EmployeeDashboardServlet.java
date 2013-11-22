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
import sjsu.cs157a.dbpro.domain.Employee;
import sjsu.cs157a.dbpro.domain.Person;

/**
 * Servlet implementation class EmployeeDashboardServlet
 */
public class EmployeeDashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger
			.getLogger(EmployeeDashboardServlet.class);

    /**
     * @see HttpServlet#HttpServlet()
     */
    public EmployeeDashboardServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		if (req.getParameter("show").equals("viewEmployeeInfo")) {
			String username = (String) req.getSession()
					.getAttribute("username");

			Connection conn = DbConnection.openConnection();

			ResultSet rs = null;
			Employee employee = new Employee();

			PreparedStatement prepStmt = null;
			String sql = "select firstName, middleName, lastName, age, birthDate, gender, hourlyPay, airlineCode, email, phone, street, city, stateProvinceCounty, country from employee "
					+ "where username = ?";

			try {
				prepStmt = conn.prepareStatement(sql);
				prepStmt.setString(1, username);
				logger.info("prepStmt: " + prepStmt.toString());
				rs = prepStmt.executeQuery();
				if (rs.next()) {
					employee.setLastName(rs.getString("lastName"));
					employee.setFirstName(rs.getString("firstName"));
					employee.setMiddleName(rs.getString("middleName"));
					employee.setAge(rs.getInt("age"));
					employee.setBirthDate(rs.getDate("birthDate"));
					String genderText = rs.getString("gender");
					employee.setGender(genderText == null ? null
							: Person.Gender.valueOf(genderText));
					employee.setEmail(rs.getString("email"));
					employee.setPhone(rs.getString("phone"));
					employee.setStreet(rs.getString("street"));
					employee.setCity(rs.getString("city"));
					employee.setStateProvinceCounty(rs
							.getString("stateProvinceCounty"));
					employee.setCountry(rs.getString("country"));
					employee.setWage(Float.parseFloat(rs.getString("hourlyPay")));
					employee.setAirlineCode(rs.getString("airlineCode"));
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
			req.setAttribute("employee", employee);
		}
		else if (req.getParameter("show").equals("editEmployeeInfo")){
			// TODO
		}
		
		// Forward to view (i.e. JSP pages).
		logger.info("forward to employeeDashboard.jsp");
		req.getRequestDispatcher("/WEB-INF/jsp/employeeDashboard.jsp")
				.forward(req, resp);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
