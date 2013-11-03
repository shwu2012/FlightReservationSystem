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
        <c:choose>
        <c:when test="${param.show eq 'viewCustomerInfo'}">
            <div id="viewCustomerInfo">
                <h2>Passenger information</h2>
                <table id="pinfo">
                    <tr>
                        <td class="custInfoLabel">
                            <span>First Name:</span>
                        </td>
                        <td class="custInfo">
                            <span id="pfn" ><c:out value="${passenger.firstName}" /></span>  
                        </td>
                    </tr>
                    <tr>
                        <td class="custInfoLabel">
                            <span >Middle Name:</span>
                        </td>
                        <td class="custInfo">
                            <span id="pmn" ><c:out value="${passenger.middleName}" /></span>  
                        </td>
                    </tr>
                    <tr>
                        <td class="custInfoLabel">
                            <span>Last Name:</span>
                        </td>
                        <td class="custInfo">
                            <span id="pln"><c:out value="${passenger.lastName}" /></span>  
                        </td>
                    </tr>
                    <tr>
                        <td class="custInfoLabel">
                            <span>Email:</span>
                        </td>
                        <td class="custInfo">
                            <span id="pem" class="custInfo"><c:out value="${passenger.email}" /></span>  
                        </td>
                    </tr>
                    <tr>
                        <td class="custInfoLabel">
                            <span>Phone:</span>
                        </td>
                        <td class="custInfo">
                            <span id="pph" ><c:out value="${passenger.phone}" /></span> 
                        </td>
                    </tr>
                    <tr>
                        <td class="custInfoLabel">
                            <span>Street:</span>
                        </td>
                        <td class="custInfo">
                            <span id="pst" ><c:out value="${passenger.street}" /></span> 
                        </td>
                    </tr>
                    <tr>
                        <td class="custInfoLabel">
                            <span>City:</span>
                        </td>
                        <td class="custInfo">
                            <span id="pc" ><c:out value="${passenger.city}" /></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="custInfoLabel">
                            <span>State:</span>
                        </td>
                        <td class="custInfo">
                            <span id="ps"><c:out value="${passenger.stateProvinceCounty}" /></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="custInfoLabel">
                            <span>Country:</span>
                        </td>
                        <td class="custInfo">
                            <span id="pc"><c:out value="${passenger.country}" /></span>
                        </td>
                    </tr>    
                </table>
                
            </div>
        </c:when>
        <c:when test="${param.show eq 'editPassengerInfo'}">
            <div id="editPassengerInfo">
                <h2>Edit Passenger Information</h2>
                <p>Fields marked with <span class="required">*</span> are required.</p>
                <div id="registerPassenger" class="register">
                    <span class="required">*</span><label for="pPassword">Password:</label><input id="pPassword" name="ppassword" class="registerSpacing" type="password"/><br/>
                    <span class="required">*</span><label for="pFirstName">First Name:</label><input id="pFirstName" class="registerSpacing" name="pfirstname" type="text"/><br/>
                    <label for="pMiddleName">Middle Name:</label><input id="pMiddleName" class="registerSpacing" name="pmiddlename" type="text"/><br/>
                    <span class="required">*</span><label for="pLastName">Last Name:</label><input id="pLastName" class="registerSpacing" name="plastname" type="text"/><br/>
                    <span class="required">*</span><label for="pEmail">Email:</label><input id="pEmail" class="registerSpacing" name="pemail" type="email"/><br/>
                    <label for="pPhone">Phone:</label><input id="pPhone" class="registerSpacing" name="pphone" type="text"/><br/>
                    <label for="pStreet">Street:</label><input id="pStreet" class="registerSpacing" name="pstreet" type="text"/><br/>
                    <label for="pCity">City:</label><input id="pCity" class="registerSpacing" name="pcity" type="text"/><br/>
                    <label for="pState">State:</label><input id="pState" class="registerSpacing" name="pstate" type="text"/><br/>
                    <label for="pCountry">Country:</label><input id="pCountry" class="registerSpacing" name="pcountry" type="text"/><br/>
                </div>
                <button id="pEditInfo" class="login">Submit</button>
            </div>
        </c:when>
        <c:when test="${param.show eq 'makeReservation'}">
            <div id="makeReservation">
                <form action="searchflights" method="post" id="searchFlightsForm">
                <h2>Make a reservation</h2>
                <label for="mr1way">One Way:</label><input id="mr1way" name="reservationType" value="oneWay" type="radio"/>
                <label for="mr2way">Round trip:</label><input id="mr2way" name="reservationType" value="roundTrip" type="radio" />
                <div id="oneWaySearch" class="hidden">
                    <label for="d1Select">Departure: </label><input type="text" id="d1Select" name="departureCity" />
                    <label for="a1Select">Arrival: </label><input type="text" id="a1Select" name="arrivalCity" />
                    <label for="seatClass1">Seat Class: </label><select id="seatClass1" name="seatClass">
                        <option value="B">Business</option>
                        <option value="E">Economy</option>
                        <option value="F">First</option>
                    </select>        
                    <label for="resDate1">Date:</label><input id="resDate1" type="date" name="departDate" />
                    <button class="searchButton" id="searchFlights1">Search</button>
                </div>
                <div id="roundTripSearch" class="hidden">
                    <label for="dSelect2">Departure: </label><input type="text" id="dSelect2" class="shortInput" name="departureDate" />
                    <label for="aSelect2">Arrival: </label><input type="text" id="aSelect2" class="shortInput" name="arrivalCity" />
                    <label for="seatClass2">Seat Class: </label><select id="seatClass2" name="seatClass">
                        <option value="B">Business</option>
                        <option value="E">Economy</option>
                        <option value="F">First</option>
                    </select>
                    <label for="resDate2">Depart Date:</label><input id="resDate2" type="date" class="shortDateInput" name="departDate" />
                    <label for="resDate3">Return Date:</label><input id="resDate3" type="date" class="shortDateInput" name="returnDate" />
                    <button class="searchButton" id="searchFlights2">Search</button>
                </div>
                </form>
            </div>
        </c:when>
        <c:when test="${param.show eq 'cancelReservation'}">
            <div id="cancelReservation">
                <h2>Cancel a reservation</h2>
                <label for="cr1way">One Way:</label><input id="cr1way" name="cancelType" type="radio"/>
                <label for="cr2way">Round trip:</label><input id="cr2way" name="cancelType" type="radio" />
                <br/>
                <div id="cancelOneWay" class="center">
                    <p>Enter a reservation number to cancel:</p>
                    <label for="resNumber">Reservation number: </label><input type="text" id="resNumber" name="reservationNumber"/>
                    <button class="cancelReservation" id="cancelRes">Cancel Reservation</button>
                </div>
                <div id="cancelRoundTrip">
                    <p>Enter Reservation numbers to cancel:</p>
                    <label for="resNum1Way">Depart Reservation Number: </label><input type="text" id="resNum1Way" name="departReservationNumber" /><button id="cancelDepart" class="cancelReservation">Cancel reservation</button> 
                    <br/>
                    <br/>
                    <label for="resNum2way">Retrun Reservation Number: </label><input type="text" id="resNum2way" name="returnReservationNumber" /><button id="cancelReturn" class="cancelReservation">Cancel reservation</button> 
                </div>
             </div>
        </c:when>
        <c:when test="${param.show eq 'viewAirports'}">    
            <div id="viewAirports">
                <h2>View Airports</h2>
                <p>View airports info goes here.</p>
            </div>
        </c:when>
        <c:when test="${param.show eq 'viewAirlinesPerAirport'}">    
            <div id="viewAirlinesPerAirport">
                <h2>View Airlines Per Airport</h2>
                <p>View airlines per airport info goes here.</p>
            </div>
        </c:when>
        </c:choose>    
        </div>
        <script type="text/javascript">
        	/*
            $("#vc").click(function(){
                $("#viewCustomerInfo").show();
                $("#editPassengerInfo").hide();
                $("#makeReservation").hide();
                $("#cancelReservation").hide();
                $("#viewAirports").hide();
                $("#viewAirlinesPerAirport").hide();
            });
            $("#ec").click(function(){
                $("#editPassengerInfo").show();
                $("#viewCustomerInfo").hide();
                $("#makeReservation").hide();
                $("#cancelReservation").hide();
                $("#viewAirports").hide();
                $("#viewAirlinesPerAirport").hide();
                $("#infoEditSuccessful").hide();
            });
            $("#mr").click(function(){
                $("#viewCustomerInfo").hide();
                $("#editPassengerInfo").hide();
                $("#makeReservation").show();
                $("#cancelReservation").hide();
                $("#viewAirports").hide();
                $("#viewAirlinesPerAirport").hide();
                $("#reservationSuccessful, #oneWaySearch, #roundTripSearch").hide();
                $("#mr1way, #mr2way").attr('checked', false);
            });
            $("#cr").click(function(){
                $("#viewCustomerInfo").hide();
                $("#editPassengerInfo").hide();
                $("#makeReservation").hide();
                $("#cancelReservation").show();
                $("#viewAirports").hide();
                $("#viewAirlinesPerAirport").hide();
                $("#cancelSuccessful, #cancelOneWay, #cancelRoundTrip").hide();
                $("#cr1way, #cr2way").attr('checked', false);
            });
            $("#va").click(function(){
                $("#viewCustomerInfo").hide();
                $("#editPassengerInfo").hide();
                $("#makeReservation").hide();
                $("#cancelReservation").hide();
                $("#viewAirports").show();
                $("#viewAirlinesPerAirport").hide();
            });
            $("#vaa").click(function(){
                $("#viewCustomerInfo").hide();
                $("#editPassengerInfo").hide();
                $("#makeReservation").hide();
                $("#cancelReservation").hide();
                $("#viewAirports").hide();
                $("#viewAirlinesPerAirport").show();
            });
            */
            $("#mr1way").change(function(){
                $("#roundTripSearch").hide();
                $("#oneWaySearch").show();
                $("#oneWayFlights, #roundTripFlights").hide();
            });
            $("#mr2way").change(function(){
                $("#oneWaySearch").hide();
                $("#roundTripSearch").show();
                $("#oneWayFlights, #roundTripFlights").hide();
            });
            $("#searchFlights1").click(function(){
                $("#oneWayFlights").show();
                var width = $("#oneWayResults").width();
                $("#reserveOneWay").width(width);
            });
            $("#searchFlights2").click(function(){
                $("#roundTripFlights").show();
                var width = $("#roundTripReturns").width();
                $("#reserveRoundTrip, #departFlightsLabel, #returnFlightsLabel").width(width);
            });
            
            $("#cr1way").change(function(){
                $("#cancelOneWay").show();
                $("#cancelRoundTrip").hide();
            });
            $("#cr2way").change(function(){
                $("#cancelRoundTrip").show();
                $("#cancelOneWay").hide();
            });
            $(".cancelReservation").click(function(){
                $("#cancelSuccessful").text("Reservation canceled successfully.").show();
                $("#cancelReservation").hide();
            });
            $(".reserve").click(function(){
                $("#reservationSuccessful").text("Reservation made successfully.").show();
                $("#makeReservation").hide();
            });
            $("#pEditInfo").click(function(){
                $("#infoEditSuccessful").text("Information edited successfully.").show();
                $("#editPassengerInfo").hide();
            });
            $("#searchFlights").click(function(){
	           	$('#searchFlightsForm').submit();
            });            
        </script>
    </div>
</body>
</html>
