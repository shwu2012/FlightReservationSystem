package sjsu.cs157a.dbpro.domain;


public class Helper
{
	public static int PassengerCount = 0;
	public static int EmployeeCount = 0;
	
	public static String parseSqlError(String sqlError, int sqlErrorCode, String tableName){
		String errorMsg = null;
		
		if ((tableName.equals("passenger"))||(tableName.equals("employee"))){
			if (sqlErrorCode == 1062){
				if (sqlError.contains("username")){
					errorMsg = "This User Name is already taken.";
				} else if (sqlError.contains("email")){
					errorMsg = "This Email is already in use.";
				}
			}
		} else if (tableName.equals("flight")) {
			if (sqlErrorCode == 1062){
				errorMsg = "This Flight Number is alreay in use.";
			} else if (sqlErrorCode == 1452) {
				if (sqlError.contains("airlineCode")){
					errorMsg = "Invalid Airline Code.";
				} else if (sqlError.contains("aircraftModel")){
					errorMsg = "Invalid Aircraft Model.";
				} else if (sqlError.contains("departureAirportCode")){
					errorMsg = "Invalid Depart Airport Code.";
				} else if (sqlError.contains("arrivalAirportCode")){
					errorMsg = "Invalid Arrival Airport Code.";
				}
			}
		} else if (tableName.equals("ticket")) {
			if (sqlErrorCode == 1062){
				errorMsg = "The combination of Flight Number, Departure Date and Seat Class is already in use.";
			} else if (sqlErrorCode == 1452) {
				errorMsg = "Invalid Flight Number.";
			}			
		} 
		return errorMsg;
	}	
}
	
