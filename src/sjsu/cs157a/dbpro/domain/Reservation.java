package sjsu.cs157a.dbpro.domain;

import java.sql.Time;
import java.sql.Date;

public class Reservation
{
	private String reservationID;
	private String flightNumber;
	private String airlineName;
	private String departureAirportCode;
	private Date departureDate;
	private Time departureTime;
	private String arrivalAirportCode;
	private Date arrivalDate;
	private Time arrivalTime;
	private String seatClass;
	private float price;
	public String getReservationID()
	{
		return reservationID;
	}
	public void setReservationID(String reservationID)
	{
		this.reservationID = reservationID;
	}
	public String getFlightNumber()
	{
		return flightNumber;
	}
	public void setFlightNumber(String flightNumber)
	{
		this.flightNumber = flightNumber;
	}
	public String getAirlineName()
	{
		return airlineName;
	}
	public void setAirlineName(String airlineName)
	{
		this.airlineName = airlineName;
	}
	public String getDepartureAirportCode()
	{
		return departureAirportCode;
	}
	public void setDepartureAirportCode(String departureAirportCode)
	{
		this.departureAirportCode = departureAirportCode;
	}
	public Date getDepartureDate()
	{
		return departureDate;
	}
	public void setDepartureDate(Date departureDate)
	{
		this.departureDate = departureDate;
	}
	public Time getDepartureTime()
	{
		return departureTime;
	}
	public void setDepartureTime(Time departureTime)
	{
		this.departureTime = departureTime;
	}
	public String getArrivalAirportCode()
	{
		return arrivalAirportCode;
	}
	public void setArrivalAirportCode(String arrivalAirportCode)
	{
		this.arrivalAirportCode = arrivalAirportCode;
	}
	public Date getArrivalDate()
	{
		return arrivalDate;
	}
	public void setArrivalDate(Date arrivalDate)
	{
		this.arrivalDate = arrivalDate;
	}
	public Time getArrivalTime()
	{
		return arrivalTime;
	}
	public void setArrivalTime(Time arrivalTime)
	{
		this.arrivalTime = arrivalTime;
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
	
	
}
