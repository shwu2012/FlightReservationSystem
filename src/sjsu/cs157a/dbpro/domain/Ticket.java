package sjsu.cs157a.dbpro.domain;

import java.util.Date;

public class Ticket {
	private Date departureDate;
	private String departureAirportCode;
	private String arrivalAirportCode;
	private String flightNumber;
	private String airlineCode;
	private String seatClass;
	private float price;
	
	public Date getDepartureDate() {
		return departureDate;
	}
	public void setDepartureDate(Date departureDate) {
		this.departureDate = departureDate;
	}
	public String getDepartureAirportCode() {
		return departureAirportCode;
	}
	public void setDepartureAirportCode(String departureAirportCode) {
		this.departureAirportCode = departureAirportCode;
	}
	public String getArrivalAirportCode() {
		return arrivalAirportCode;
	}
	public void setArrivalAirportCode(String arrivalAirportCode) {
		this.arrivalAirportCode = arrivalAirportCode;
	}
	public String getFlightNumber() {
		return flightNumber;
	}
	public void setFlightNumber(String flightNumber) {
		this.flightNumber = flightNumber;
	}
	public String getAirlineCode() {
		return airlineCode;
	}
	public void setAirlineCode(String airlineCode) {
		this.airlineCode = airlineCode;
	}	
	public String getSeatClass() {
		return seatClass;
	}
	public void setSeatClass(String seatClass) {
		this.seatClass = seatClass;
	}	
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}

	
	

}
