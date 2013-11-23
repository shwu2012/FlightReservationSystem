package sjsu.cs157a.dbpro.domain;

import java.sql.Date;

public class FirstStatistic
{
	private String flightNumber;	
	private Date departureDate;	
	private int avgAge;
	
	public String getFlightNumber()
	{
		return flightNumber;
	}
	public void setFlightNumber(String flightNumber)
	{
		this.flightNumber = flightNumber;
	}
	public Date getDepartureDate()
	{
		return departureDate;
	}
	public void setDepartureDate(Date departureDate)
	{
		this.departureDate = departureDate;
	}
	public int getAvgAge()
	{
		return avgAge;
	}
	public void setAvgAge(int avgAge)
	{
		this.avgAge = avgAge;
	}
	
	
	
	
}
