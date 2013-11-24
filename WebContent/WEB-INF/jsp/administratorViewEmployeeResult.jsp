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
        <h2>test title</h2>
        <table class="result">
          <tr>
            <th>User</th>
            <th>Name</th>
            <th>Age</th>
            <th>Wage</th>
            <th>Birth Date</th>
            <th>Gender</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Address</th>
            <th>Airline</th>
          </tr>
          <c:forEach items="${employees}" var="employee">
          <tr>
            <td><c:out value="${employee.userName}" /></td>
            <td><c:out value="${employee.firstName} ${fn:toUpperCase(employee.lastName)}" /></td>
            <td><c:out value="${employee.age}" /></td>
            <td><c:out value="${employee.wage}" /></td>
            <td><c:out value="${employee.birthDate}" /></td>
            <td><c:out value="${employee.gender}" /></td>
            <td><c:out value="${employee.email}" /></td>
            <td><c:out value="${employee.phone}" /></td>
            <td><c:out value="${employee.street}"/><br/>
              <c:out value="${employee.city}, ${employee.stateProvinceCounty} ${employee.country}" /></td>
            <td><c:out value="${employee.airlineCode}" /></td>
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
