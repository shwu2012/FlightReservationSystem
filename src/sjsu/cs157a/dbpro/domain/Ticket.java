package sjsu.cs157a.dbpro.domain;

import java.sql.Date;
import java.sql.Time;

public class Ticket {
	private String ticketID;
	private String airlineName;
	private Date departureDate;
	private Date arrivalDate;
	private Time departureTime;
	private Time arrivalTime;
	private String flightNumber;
	private String seatClass;
	private float price;
	private int availableSeats;
	
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
	public String getTicketID()
	{
		return ticketID;
	}
	public void setTicketID(String ticketID)
	{
		this.ticketID = ticketID;
	}
	public String getAirlineName()
	{
		return airlineName;
	}
	public void setAirlineName(String airlineName)
	{
		this.airlineName = airlineName;
	}
	public Date getDepartureDate()
	{
		return departureDate;
	}
	public void setDepartureDate(Date departureDate)
	{
		this.departureDate = departureDate;
	}
	public Date getArrivalDate()
	{
		return arrivalDate;
	}
	public void setArrivalDate(Date arrivalDate)
	{
		this.arrivalDate = arrivalDate;
	}
	public String getFlightNumber()
	{
		return flightNumber;
	}
	public void setFlightNumber(String flightNumber)
	{
		this.flightNumber = flightNumber;
	}
	public String getSeatClass()
	{
		return seatClass;
	}
	public void setSeatClass(String seatClass)
	{
		this.seatClass = seatClass;
	}
	public float getPrice()
	{
		return price;
	}
	public void setPrice(float price)
	{
		this.price = price;
	}
	public int getAvailableSeats()
	{
		return availableSeats;
	}
	public void setAvailableSeats(int availableSeats)
	{
		this.availableSeats = availableSeats;
	}

	
	

}
