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
                <div id="1WayReservationSuccessful">
                    <p>Reservation made successfully for <span id="passengerName1Way"><c:out value="${username}"/></span> </p>
                    <table class="center flightSearchResults">
                        <tr class="bold">
                            <td>Reservation<br/>Number</td>
                            <td>Flight<br/>Number</td>
                            <td>Airline</td>
                            <td>Departure<br/>Airport</td>
                            <td>Departure<br/>Date</td>
                            <td>Departure<br/>Time</td>
                            <td>Arrival<br/>Airport</td>
                            <td>Arrival<br/>Date</td>
                            <td>Arrival<br/>Time</td>
                            <td>Seat<br/>Class</td>
                            <td>Price</td>
                        </tr>
                        <c:forEach items="${reservations}" var="reservation" varStatus="status">
                            <tr>
                                <td><c:out value="${reservation.reservationID}"/></td>
                                <td><c:out value="${reservation.flightNumber}"/></td>
                                <td><c:out value="${reservation.airlineName}"/></td>
                                <td><c:out value="${reservation.departureAirportCode}"/></td>
                                <td><c:out value="${reservation.departureDate}"/></td>
                                <td><c:out value="${reservation.departureTime}"/></td>
                                <td><c:out value="${reservation.arrivalAirportCode}"/></td>
                                <td><c:out value="${reservation.arrivalDate}"/></td>
                                <td><c:out value="${reservation.arrivalTime}"/></td>
                                <td><c:out value="${reservation.seatClass}"/></td>
                                <td><c:out value="${reservation.price}"/></td>                                
                            </tr>
                       </c:forEach>
                    </table>
                </div>      
                               
            </div>
        </div>
    </div>    
</body>
</html>
