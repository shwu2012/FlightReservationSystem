DROP DATABASE IF EXISTS AIRLINERESERVATION;
CREATE DATABASE AIRLINERESERVATION;
USE AIRLINERESERVATION;

DROP TABLE IF EXISTS PASSENGER;
CREATE TABLE PASSENGER
(passengerID VARCHAR(10),
 username VARCHAR (10),
 pwd VARCHAR (10) not null,
 lastName VARCHAR(30) not null,
 firstName VARCHAR(30) not null,
 middleName VARCHAR(30),
 age INT,
 birthDate DATE not null,
 gender VARCHAR(1), 
 email VARCHAR(30) not null, 
 phone VARCHAR(15),
 street VARCHAR(50),
 city VARCHAR(30),
 stateProvinceCounty VARCHAR(30),
 country VARCHAR(30),
 PRIMARY KEY(passengerID),
 UNIQUE(email)
);

DROP TABLE IF EXISTS AIRLINE;
CREATE TABLE AIRLINE
(airlineCode VARCHAR(10),
 airlineName VARCHAR(30) not null,
 PRIMARY KEY(airlineCode)
);

DROP TABLE IF EXISTS AIRCRAFT;
CREATE TABLE AIRCRAFT
(aircraftModel VARCHAR(30),
 firstCapacity INT,
 businessCapacity INT,
 economyCapacity INT,
 manufacPlace VARCHAR(30),
 manufacDate DATE,
 PRIMARY KEY(aircraftModel)
);

DROP TABLE IF EXISTS AIRPORT;
CREATE TABLE AIRPORT
(airportCode VARCHAR(10),
 airportName VARCHAR(30) not null,
 city VARCHAR(30) not null,
 country VARCHAR(30),
 PRIMARY KEY(airportCode)
);

DROP TABLE IF EXISTS EMPLOYEE;
CREATE TABLE EMPLOYEE
(employeeID VARCHAR(10),
 username VARCHAR(10),
 pwd VARCHAR(10),
 lastName VARCHAR(30) not null,
 firstName VARCHAR(30) not null,
 middleName VARCHAR(30),
 gender VARCHAR(1),
 age INT,
 birthDate DATE not null,
 hourlyPay Float not null,
 email VARCHAR(30) not null,
 phone VARCHAR(15),
 street VARCHAR(50),
 city VARCHAR(30),
 stateProvinceCounty VARCHAR(30),
 country VARCHAR(30),
 airlineCode VARCHAR(10),
 PRIMARY KEY(employeeID),
 UNIQUE(email)
);

DROP TABLE IF EXISTS FLIGHT;
CREATE TABLE FLIGHT
(flightNumber VARCHAR(10),
 airlineCode VARCHAR(10),
 aircraftModel VARCHAR(30),
 departureAirportCode VARCHAR(10),
 arrivalAirportCode VARCHAR(10),
 departureTime TIME,
 arrivalTime TIME,
 overnight boolean,
 PRIMARY KEY (flightNumber),
 FOREIGN KEY (airlineCode) REFERENCES AIRLINE(airlineCode) 
     ON DELETE CASCADE
	 ON UPDATE CASCADE,
 FOREIGN KEY (aircraftModel) REFERENCES AIRCRAFT(aircraftModel) 
     ON DELETE CASCADE
	 ON UPDATE CASCADE
); 

DROP TABLE IF EXISTS TICKET;
CREATE TABLE TICKET
(ticketID VARCHAR(10),
 flightNumber VARCHAR(10),
 departureDate DATE,
 arrivalDate DATE,
 seatClass VARCHAR(1),
 availableSeats INT,
 price INT,
 updateAt TIMESTAMP,
 PRIMARY KEY (ticketID),
 FOREIGN KEY (flightNumber) REFERENCES FLIGHT(flightNumber) 
     ON DELETE CASCADE
	 ON UPDATE CASCADE
);

DROP TABLE IF EXISTS RESERVATION;
CREATE TABLE RESERVATION
(reservationID VARCHAR(20),
 passengerID VARCHAR(10),
 ticketID VARCHAR(10),
 updateAt TIMESTAMP,
 PRIMARY KEY(reservationID),
 FOREIGN KEY (passengerID) REFERENCES PASSENGER(passengerID) 
     ON DELETE CASCADE
	 ON UPDATE CASCADE,
 FOREIGN KEY (ticketID) REFERENCES TICKET(ticketID) 
     ON DELETE CASCADE
	 ON UPDATE CASCADE
);

DROP TABLE IF EXISTS RECORD;
CREATE TABLE RECORD
(passengerCount INT default 9,
 employeeCount INT default 10,
 ticketCount INT default 8,
 reservationCount INT default 5
);

DROP TRIGGER IF EXISTS ReservationInsertTrigger;
delimiter //
CREATE TRIGGER ReservationInsertTrigger
AFTER INSERT ON RESERVATION
FOR EACH ROW
BEGIN
	UPDATE TICKET SET availableSeats = availableSeats - 1 WHERE ticketID = NEW.ticketID;
	#UPDATE PASSENGER SET reservationCount = reservationCount + 1 WHERE passengerID = NEW.passengerID;
	UPDATE RECORD SET reservationCount = reservationCount + 1;
END;//
delimiter ;

DROP TRIGGER IF EXISTS ReservationDeleteTrigger;
delimiter //
CREATE TRIGGER ReservationDeleteTrigger
AFTER DELETE ON RESERVATION
FOR EACH ROW
BEGIN
	UPDATE TICKET SET availableSeats = availableSeats + 1 WHERE ticketID = OLD.ticketID;
	#UPDATE PASSENGER SET reservationCount = reservationCount - 1 WHERE passengerID = OLD.passengerID;
	
END;//
delimiter ;

DROP TRIGGER IF EXISTS PassengerInsertTrigger;
delimiter //
CREATE TRIGGER PassengerInsertTrigger
AFTER INSERT ON PASSENGER
FOR EACH ROW
BEGIN
	UPDATE RECORD SET passengerCount = passengerCount + 1;
END;//
delimiter ;

DROP TRIGGER IF EXISTS EmployeeInsertTrigger;
delimiter //
CREATE TRIGGER EmployeeInsertTrigger
AFTER INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN
	UPDATE RECORD SET employeeCount = employeeCount + 1;
END;//
delimiter ;

DROP TRIGGER IF EXISTS TicketInsertTrigger;
delimiter //
CREATE TRIGGER TicketInsertTrigger
AFTER INSERT ON TICKET
FOR EACH ROW
BEGIN
	UPDATE RECORD SET ticketCount = ticketCount + 1;
END;//
delimiter ;



LOAD DATA LOCAL INFILE 'c:\\SQL\\passenger.txt' INTO TABLE PASSENGER;
LOAD DATA LOCAL INFILE 'c:\\SQL\\airline.txt' INTO TABLE AIRLINE;
LOAD DATA LOCAL INFILE 'c:\\SQL\\aircraft.txt' INTO TABLE AIRCRAFT;
LOAD DATA LOCAL INFILE 'c:\\SQL\\airport.txt' INTO TABLE AIRPORT;
LOAD DATA LOCAL INFILE 'c:\\SQL\\employee.txt' INTO TABLE EMPLOYEE;
LOAD DATA LOCAL INFILE 'c:\\SQL\\flight.txt' INTO TABLE FLIGHT;
LOAD DATA LOCAL INFILE 'c:\\SQL\\ticket.txt' INTO TABLE TICKET;
LOAD DATA LOCAL INFILE 'c:\\SQL\\reservation.txt' INTO TABLE RESERVATION;
LOAD DATA LOCAL INFILE 'c:\\SQL\\record.txt' INTO TABLE RECORD;