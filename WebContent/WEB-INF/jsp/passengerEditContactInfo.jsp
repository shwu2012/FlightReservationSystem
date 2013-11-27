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
            <div id="editPassengerInfo">
                <h2>Edit Passenger Information</h2>
                <c:choose>
                <c:when test="${empty sqlError}">
                <p>Information edited successfully.<p>
                </c:when>
                <c:otherwise>
                Error: <c:out value="${sqlError}" />
                </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</body>
</html>