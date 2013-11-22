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
            <div id="makeReservation">
                <h2>One way reservation</h2>
                <div>
                <c:out value="Departure: ${departureCity} (${departureAirportCode})" /><br/>
                <c:out value="Arrival: ${arrivalCity} (${arrivalAirportCode})" /><br/>
                <c:out value="Depart Date: ${departDate}" /><br/>
                <c:out value="Seat Class: ${seatClass}" />
                </div>
                <div id="oneWaySearch">
                    <div id="oneWayFlights">
                    <c:choose>
                    <c:when test="${empty tickets}">
                        No tickets found.
                    </c:when>
                    <c:otherwise>
                    <form action="makeReservation" method="post" id="reservationForm">
                        <table id="oneWayResults" class="flightSearchResults center tableBorder">
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
                                <td><input type="radio" name="flightSelected" value="${ticket.ticketID}" /></td>
                            </tr>
                            </c:forEach>
                        </table>
                        <input type="hidden" name="reservationType" value="oneWay" />
                        </form>
                        <div id="reserveOneWay" class="center textAlignRight" >
                            <button id="reserve" class="reserve">Reserve Flight</button>
                        </div>
                    </c:otherwise>
                    </c:choose>    
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
