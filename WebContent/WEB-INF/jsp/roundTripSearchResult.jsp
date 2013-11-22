<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Passenger Dashboard</title>
    <meta charset="UTF-8" />
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="css/main.css" />
</head>
<body>
    <div id="main" class="center">
        <div id="header">
            <h1>Passenger Dashboard</h1>
            <div id="welcome">
                <span>Welcome, </span>
                <span id="userName"><c:out value="${username}"/></span>
            </div>
            <div id="logout">
                <a id="userLogout" href="logout">Logout</a>
            </div>
        </div>
        <div id="menu">
            <ul id="menuItems">
                <li class="menuOption" id="vc"><a href="passengerdashboard?show=viewCustomerInfo">View contact info</a></li>
                <li class="menuOption" id="ec"><a href="passengerdashboard?show=editPassengerInfo">Edit contact info</a></li>
                <li class="menuOption" id="mr"><a href="passengerdashboard?show=makeReservation">Make a reservation</a></li>
                <li class="menuOption" id="cr"><a href="passengerdashboard?show=cancelReservation">Cancel a reservation</a></li>
                <li class="menuOption" id="va"><a href="passengerdashboard?show=viewReservations">View reservations</a></li>
            </ul>
        </div>
        <div id="contentArea">
                <h2>Round trip reservation</h2>
                <div>
                <c:out value="Departure: ${departureCity} (${departureAirportCode})" /><br/>          
                <c:out value="Arrival: ${arrivalCity} (${arrivalAirportCode})" /><br/>
                <c:out value="Depart Date: ${departDate}" /><br/>
                <c:out value="Return Date: ${returnDate}" /><br/>
                <c:out value="Seat Class: ${seatClass}" />
                </div>
                <div id="roundTripSearch">
                    <div id="roundTripFlights">
                        <div id="departFlightsLabel" class="textAlignLeft center">Departing flights:</div>
                        <form action="makeReservation" method="post" id="reservationForm">
                        <table id="roundTripDepartures" class="flightSearchResults center tableBorder">
                            <tr class="bold">
                                <td>Airline</td><td>Flight #</td><td>Depart Time</td><td>Arrive Time</td><td>Price</td><td># of Seats</td><td>Select</td>
                            </tr>
                            <c:forEach items="${tickets}" var="ticket" varStatus="status">
                            <tr>
                                <td><c:out value="${ticket.airlineName}"/></td>
                                <td><c:out value="${ticket.flightNumber}"/></td>
                                <td><c:out value="${ticket.departureTime}"/></td>
                                <td><c:out value="${ticket.arrivalTime}"/></td>
                                <td><c:out value="${ticket.price}"/></td>
                                <td><c:out value="${ticket.availableSeats}"/></td>
                                <td><input type="radio" name="departFlightSelected" value="${ticket.ticketID}" /></td>
                            </tr>
                            </c:forEach>
                        </table>
                        <div id="returnFlightsLabel" class="textAlignLeft center">Return flights:</div>
                        <table id="roundTripReturns" class="flightSearchResults center tableBorder">
                            <tr class="bold">
                                <td>Airline</td><td>Flight #</td><td>Depart Time</td><td>Arrive Time</td><td>Price</td><td># of Seats</td><td>Select</td>
                            </tr>
                            <c:forEach items="${returnTickets}" var="ticket" varStatus="status">
                            <tr>
                                <td><c:out value="${ticket.airlineName}"/></td>
                                <td><c:out value="${ticket.flightNumber}"/></td>
                                <td><c:out value="${ticket.departureTime}"/></td>
                                <td><c:out value="${ticket.arrivalTime}"/></td>
                                <td><c:out value="${ticket.price}"/></td>
                                <td><c:out value="${ticket.availableSeats}"/></td>
                                <td><input type="radio" name="returnFlightSelected" value="${ticket.ticketID}" /></td>
                            </tr>
                            </c:forEach>
                        </table>
                        <input type="hidden" name="reservationType" value="roundTrip" />
                        </form>
                        <div id="reserveRoundTrip" class ="center textAlignRight" >
                            <button id="reserve" class="reserve">Reserve Flights</button>
                        </div>
                    </div>
                </div>
        </div>
    </div>
    <script type="text/javascript">
                $("#reserve").click(function(){
	           	$('#reservationForm').submit();
            });
    </script>
</body>

</html>
