package sjsu.cs157a.dbpro.domain;

public class Passenger extends Person{
	private int reservationCount;

	public int getReservationCount() {
		return reservationCount;
	}

	public void setReservationCount(int reservationCount) {
		this.reservationCount = reservationCount;
	}
	
	
}
