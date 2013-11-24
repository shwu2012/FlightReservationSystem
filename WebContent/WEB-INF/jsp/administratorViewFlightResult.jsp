<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <title>Administrator Dashboard</title>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js">
    </script>
    <link rel="stylesheet" type="text/css" href="css/admin.css" />
</head>
<body>
    <div id="main" class="center">
        <div id="header">
            <h1>Administrator Dashboard</h1>
            <div id="welcome">
                <span>Welcome, </span>
                <span id="userName"><c:out value="${username}"/></span>
            </div>
            <div id="logout">
                <a id="userLogout" href="logout">Logout</a>
            </div>
        </div>
        <div id="menu" class="centerText">
            <ul id="mainMenu" class="menuItems">
                <li class="menuOption"><a href="administratordashboard?show=view">View</a></li>
                <li class="menuOption"><a href="administratordashboard?show=modifications">Modifications</a></li>
                <li class="menuOption"><a href="administratordashboard?show=statistics">Statistics</a></li>
                <li class="menuOption"><a href="administratordashboard?show=archive">Archive Database</a></li>
            </ul>
        </div>
        <div id="contentArea">
        <c:choose>
        <c:when test="${empty sqlError}">
        <div class="centerText">
        <h2>Flight Information</h2>
        <table class="result">
         <tr>
            <th>Flight Number</th>
            <th>Airline Code</th>
            <th>Aircraft Model</th>
            <th>Departure Airport Code</th>
            <th>Arrival Airport Code</th>
            <th>Departure Time</th>
            <th>Arrival Time</th>            
          </tr>
          <c:forEach items="${flights}" var="flight">
          <tr>
            <td><c:out value="${flight.flightNumber}" /></td>
            <td><c:out value="${flight.airlineCode}" /></td>
            <td><c:out value="${flight.aircraftModel}" /></td>
            <td><c:out value="${flight.departureAirportCode}" /></td>
            <td><c:out value="${flight.arrivalAirportCode}" /></td>
            <td><c:out value="${flight.departureTime}" /></td>
            <td><c:out value="${flight.arrivalTime}" /></td>
          </tr>
          </c:forEach>
        </table>
        </div>
        </c:when>
        <c:otherwise>
        SQL error: <c:out value="${sqlError}" /> 
        </c:otherwise>
        </c:choose>
        </div>
    </div>
</body>
