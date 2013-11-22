<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Administrator Dashboard</title>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js">
    </script>
    <style type="text/css">
        body
        {
            background-image: url("http://blog.heartland.org/wp-content/uploads/2013/08/Boeing-787-Dreamliner1-1.jpg");
            background-size: cover;
        }
        #main
        {
            width: 1050px;
            background-color: rgba(255, 255, 255, 0.9);
            padding: 10px;
            font-size: 14pt;
        }
        #header
        {
            text-align: center;
            position: relative;
            padding-bottom: 1px;
        }

        .centerText
        {
            text-align: center;
        }
        .menuOption
        {
            display: inline;
            border: 1px solid #000;
            padding: 10px;
            background-color: #1975FF;
            border-radius: 5px;
            color: #FFF;
        }
        .menuOption:hover
        {
            background-color: #4791FF;
            cursor: pointer;
            color: #000;
        }
        .menuItems
        {
            list-style: none;
            padding: 0;
            border: 1px solid #555;
            border-radius: 3px;
        }
        .menuItems a
        {
            color: white;
            text-decoration: none;
        }
        .modOption
        {
            padding: 10px;
            background-color: #FCFCFC;
            color: black;
            position: relative;
            border-bottom: 1px solid #555;
        }

        .modOption:hover
        {
            background-color: #E3E3E3;
            cursor: pointer;
        }
        #statsOptions
        {
            border: 1px solid #555;
            width: 600px;
            background-color: #FCFCFC;
            list-style-type: none;
            padding: 0;
            font-size: 13pt;
        }
        .statOption
        {
            padding: 10px;
            background-color: #FCFCFC;
            color: black;
            position: relative;
            border-bottom: 1px solid #555;
        }
        .statOption:hover
        {
            background-color: #E3E3E3;
            cursor: pointer;
        }
        #modItems
        {
            width: 125px;
        }

        .innerModOptionItem
        {
            padding: 10px;
            background-color: #FCFCFC;
            color: black;
            border-bottom: 1px solid #777;
            position: relative;
        }
        .innerModOptionItem:hover
        {
            background-color: #E3E3E3;
            cursor: pointer;
        }
        #welcome
        {
            position: absolute;
            top: 10px;
            left: 10px;
        }
        #userLogout
        {
            text-decoration: none;
            color: #000;
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 14pt;
        }
        #userLogout:hover
        {
            color: #888;
        }
        #contentArea
        {
            padding: 10px;
            margin-top: 10px;
        }
        .login
        {
            padding: 8px;
            border-radius: 5px;
            background-color: #1975FF;
            margin-top: 10px;
        }
        button
        {
            font-size: 16px;
            color: #FFF;
            border: 1px solid #000;
            cursor: pointer;
        }
        .login:hover
        {
            background-color: #4791FF;
        }
        .hidden
        {
            display: none;
        }
        .center
        {
            margin: auto;
        }
        .innerModOption
        {
            width: 150px;
            position: absolute;
            top: 0;
            left: 132px;
            display:none;
        }
        .blackTriangleRight
        {
            width: 0;
            height: 0;
            border-left: 7px solid #000;
            border-top: 7px solid transparent;
            border-bottom: 7px solid transparent;
            display:inline-block;
            position: absolute;
            top: 13px;
            right: 10px;
        }
        .blackTriangleDown
        {
            border-top: 7px solid #000;
            border-right: 7px solid transparent;
            border-left: 7px solid transparent;
            top: 17px;
        }
        .whiteTriangleLeft
        {
            border-right: 8px solid #FFF;
            border-top: 8px solid transparent;
            border-bottom: 8px solid transparent;
            position: absolute;
            top: 15px;
            left: -7px;
        }
        .greyTriangleLeft
        {
            border-right: 8px solid #555;
            border-top: 8px solid transparent;
            border-bottom: 8px solid transparent;
            position: absolute;
            top: 15px;
            left: -8px;
        }
        #mainMenu
        {
            border: hidden;
        }
        #modMenu
        {
            width: 250px;
            float: left;
        }
        #modCommands
        {
            padding: 10px 10px 10px 260px;
        }
        .reserve
        {
            padding: 4px;
            font-size: 15px;
            border-radius: 5px;
            background-color: #228B22;
            margin-top: 10px;
        }
        .reserve:hover
        {
            background-color: #32CD32;
        }
        h4
        {
            margin-bottom: 5px;
        }
        input
        {
            margin: 5px;
        }
    </style>
</head>
<body>
    <div id="main" class="center">
        <div id="header">
            <h1>Administrator Dashboard</h1>
            <div id="welcome">
                <span>Welcome, </span>
                <span id="userName">Clark</span>
            </div>
            <div id="logout">
                <a id="userLogout" href="Main Login Page.html">Logout</a>
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
        Operation is successful.
        </c:when>
        <c:otherwise>
        SQL error: <c:out value="${sqlError}" /> 
        </c:otherwise>
        </c:choose>
        </div>
    </div>
</body>
