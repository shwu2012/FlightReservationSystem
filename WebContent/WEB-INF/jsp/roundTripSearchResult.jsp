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
                <li class="menuOption" id="va"><a href="passengerdashboard?show=viewAirports">View airports</a></li>
                <li class="menuOption" id="vaa"><a href="passengerdashboard?show=viewAirlinesPerAirport">View airlines per airport</a></li>
            </ul>
        </div>
        <div id="contentArea">
                <h2>Round trip reservation</h2>
                <h3>TODO</h3>
                <div id="roundTripSearch">
                    <div id="roundTripFlights">
                        <div id="departFlightsLabel" class="textAlignLeft center">Departing flights:</div>
                        <table id="roundTripDepartures" class="flightSearchResults center tableBorder">
                            <tr class="bold">
                                <td>Airline</td><td>Flight #</td><td>Depart Time</td><td>Arrive Time</td><td>Price</td><td># of Seats</td><td>Select</td>
                            </tr>
                            <tr>
                                <td>United Airlines</td><td>UA858</td><td>13:20:00</td><td>15:25:00</td><td>600.5</td><td>19</td><td><input type="radio" name="flightSelected" /></td>
                            </tr>
                            <tr>
                                <td>United Airlines</td><td>UA858</td><td>13:20:00</td><td>15:25:00</td><td>600.5</td><td>19</td><td><input type="radio" name="flightSelected" /></td>
                            </tr>
                            <tr>
                                <td>United Airlines</td><td>UA858</td><td>13:20:00</td><td>15:25:00</td><td>600.5</td><td>19</td><td><input type="radio" name="flightSelected" /></td>
                            </tr>
                        </table>
                        <div id="returnFlightsLabel" class="textAlignLeft center">Return flights:</div>
                        <table id="roundTripReturns" class="flightSearchResults center tableBorder">
                            <tr class="bold">
                                <td>Airline</td><td>Flight #</td><td>Depart Time</td><td>Arrive Time</td><td>Price</td><td># of Seats</td><td>Select</td>
                            </tr>
                            <tr>
                                <td>United Airlines</td><td>UA858</td><td>13:20:00</td><td>15:25:00</td><td>600.5</td><td>19</td><td><input type="radio" name="flightSelected" /></td>
                            </tr>
                            <tr>
                                <td>United Airlines</td><td>UA858</td><td>13:20:00</td><td>15:25:00</td><td>600.5</td><td>19</td><td><input type="radio" name="flightSelected" /></td>
                            </tr>
                            <tr>
                                <td>United Airlines</td><td>UA858</td><td>13:20:00</td><td>15:25:00</td><td>600.5</td><td>19</td><td><input type="radio" name="flightSelected" /></td>
                            </tr>
                        </table>
                        <div id="reserveRoundTrip" class ="center textAlignRight" >
                            <button class="reserve">Reserve Flights</button>
                        </div>
                    </div>
                </div>
        </div>
    </div>
</body>
</html>
