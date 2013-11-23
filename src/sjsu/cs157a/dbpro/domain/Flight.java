package sjsu.cs157a.dbpro.domain;

import java.sql.Time;

public class Flight
{
	private String flightNumber;
	private String airlineCode;
	private String aircraftModel;
	private String departureAirportCode;
	private String arrivalAirportCode;
	private Time departureTime;
	private Time arrivalTime; 
	private boolean overnight;
	
	public String getFlightNumber()
	{
		return flightNumber;
	}
	public void setFlightNumber(String flightNumber)
	{
		this.flightNumber = flightNumber;
	}
	public String getAirlineCode()
	{
		return airlineCode;
	}
	public void setAirlineCode(String airlineCode)
	{
		this.airlineCode = airlineCode;
	}
	public String getAircraftModel()
	{
		return aircraftModel;
	}
	public void setAircraftModel(String aircraftModel)
	{
		this.aircraftModel = aircraftModel;
	}
	public String getDepartureAirportCode()
	{
		return departureAirportCode;
	}
	public void setDepartureAirportCode(String departureAirportCode)
	{
		this.departureAirportCode = departureAirportCode;
	}
	public String getArrivalAirportCode()
	{
		return arrivalAirportCode;
	}
	public void setArrivalAirportCode(String arrivalAirportCode)
	{
		this.arrivalAirportCode = arrivalAirportCode;
	}
	public Time getDepartureTime()
	{
		return departureTime;
	}
	public void setDepartureTime(Time departureTime)
	{
		this.departureTime = departureTime;
	}
	public Time getArrivalTime()
	{
		return arrivalTime;
	}
	public void setArrivalTime(Time arrivalTime)
	{
		this.arrivalTime = arrivalTime;
	}
	public boolean isOvernight()
	{
		return overnight;
	}
	public void setOvernight(boolean overnight)
	{
		this.overnight = overnight;
	}	

}
