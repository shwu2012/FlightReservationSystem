package sjsu.cs157a.dbpro.domain;

public class Employee extends Person
{
	private float wage;	
	private String airlineCode;
	public float getWage()
	{
		return wage;
	}
	public void setWage(float wage)
	{
		this.wage = wage;
	}
	public String getAirlineCode()
	{
		return airlineCode;
	}
	public void setAirlineCode(String airlineCode)
	{
		this.airlineCode = airlineCode;
	}
	
	
	
}
