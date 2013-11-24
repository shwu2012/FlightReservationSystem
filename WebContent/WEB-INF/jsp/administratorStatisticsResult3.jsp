<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
        <h2>First name, Last name, and email address of the passengers 
        who take flight <nobr>&ldquo;<c:out value="${flightNumber}" />&rdquo;</nobr>, 
        with age over <nobr><c:out value="${age}" /></nobr></h2>
        <table class="result">
          <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Email</th>
          </tr>
          <c:forEach items="${thirdStatistics}" var="item">
          <tr>
            <td><c:out value="${item.firstName}" /></td>
            <td><c:out value="${item.lastName}" /></td>
            <td><c:out value="${item.email}" /></td>
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
