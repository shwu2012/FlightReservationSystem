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
                <span id="userName"><c:out value="${username}"/></span>
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
        <c:when test="${param.show eq 'view'}">
            <!-- view container -->
            <div id="view">
                <div id="modMenu">
                <h3>View Selection:</h3>
                <ul id="modItems" class="menuItems">
                    <li class="modOption">Employee</li>
                    <li class="modOption">Flight</li>
                    <li class="modOption">Ticket</li>
                </ul>
                </div>
                <div style="clear:both"></div>
            </div>
        </c:when>
        <c:when test="${param.show eq 'modifications'}">
            <!-- modifications container -->
            <div id="modifications">
                <div id="modMenu">
                <h3>Modification Selection:</h3>
                <ul id="modItems" class="menuItems">
                    <li class="modOption">Employee <div class="blackTriangleRight"></div>
                        <ul id="employeeMods" class="menuItems innerModOption">
                            <li id="UE" class="innerModOptionItem">
                                <div class="greyTriangleLeft"></div>
                                <div class="whiteTriangleLeft" ></div>
                                Update Wage</li>
                            <li id="DE" class="innerModOptionItem">Delete Employee</li>
                        </ul>
                    </li>
                    <li class="modOption">Flight<div class="blackTriangleRight"></div>
                        <ul id="flightMods" class="menuItems innerModOption">
                            <li id="IF" class="innerModOptionItem">
                                <div class="greyTriangleLeft"></div>
                                <div class="whiteTriangleLeft" ></div>Insert Flight</li>
                            <li id="UF" class="innerModOptionItem">Update Flight</li>
                            <li id="DF" class="innerModOptionItem">Delete Flight</li>
                        </ul>
                    </li>
                    <li class="modOption">Ticket<div class="blackTriangleRight"></div>
                        <ul id="ticketMods" class="menuItems innerModOption">
                            <li id="IT" class="innerModOptionItem">
                                <div class="greyTriangleLeft"></div>
                                <div class="whiteTriangleLeft" ></div>Insert Ticket</li>
                            <li id="UT" class="innerModOptionItem">Update Ticket</li>
                            <li id="DT" class="innerModOptionItem">Delete Ticket</li>
                        </ul>
                    </li>
                </ul>
                </div>
                <div id="modCommands">

                    <!-- container for error or success messages-->
                    <div id="message" class="hidden">

                    </div>

                    <!--Employee Delete-->
                    <div id="updateWage" class="hidden">
                        <h4>Update Wage:</h4>
                        <form action="employeeoperation?op=update" method="post" id="updateEmployeeForm">
                        <label for="Wage">New Wage:</label><input id="Wage" name="hourlyPay" type="text" />
                        <br/>
                        <label for="ID" >For employee Username = </label><input id="ID" type="text" name="employeeUsername" />
                        <div class="centerText">
                            <button class="reserve update">Update</button>
                        </div>
                        </form>
                    </div>
                    <div id="deleteEmployee" class="hidden">
                        <h4>Delete Employee:</h4>
                        <form action="employeeoperation?op=delete" method="post" id="deleteEmployeeForm">
                        <label for="employeeID">Employee Username:</label><input id="employeeID" type="text" name="employeeUsername" /><button class="reserve delete">Delete</button>
                        </form>
                    </div>

                    <!--Ticket insert, update, delete-->
                    <div id="insertTicket" class="hidden">
                        <h4>Add Ticket:</h4>
                        <form action="ticketoperation?op=insert" method="post" id="insertTicketForm">
                        <label for="flightNum">Flight Number:</label><input id="flightNum" type="text" name="ticketFlightNumber" />
                        <br/>
                        <label for="dDate">Departure Date:</label><input id="dDate" type="date" name="departureDate" />
                        <br/>
                        <label for="aDate">Arrival Date:</label><input id="aDate" type="date" name="arrivalDate" />
                        <br/>
                        <label for="seat">Seat Class:</label>
                            <select id="class" name="seatClass">
                                <option value="F">First Class</option>
                                <option value="B">Business Class</option>
                                <option value="E">Economy Class</option>
                            </select>
                        <br/>
                        <label for="seats">Available Seats:</label><input id="seats" type="number" name="availableSeats" />
                        <br/>
                        <label for="price">Selected Seat Price:</label><input id="price" type="text" name="price" />
                        <div class="centerText">
                            <button class="reserve insert">Add Ticket</button>
                        </div>
                        </form>
                    </div>
                    <div id="updateTicket" class="hidden">
                        <h4>Update Ticket:</h4>
                        <form action="ticketoperation?op=update" method="post" id="updateTicketForm">
                        <label for="ticketAttr">Attribute to update:</label>
                        <select id="ticketAttr" name="ticketAttribute">
                            <option value="availableSeats">Available Seats</option>
                            <option value="price">Seat Price</option>
                        </select>
                        <br/>
                        <label for="tAttrVal">New Attribute Value:</label><input id="tAttrVal" name="ticketAttributeValue" type="text"/>
                        <br/>
                        <label for="ticket">For flight number =</label><input type="text" id="ticket" name="flightNum" />
                        <br/>
                        <label for="ticket1">and flight departure date = </label><input type="date" id="ticket1" name="depDate" />
                        <br/>
                        <label for="seat_class">and seat class = </label>
                            <select id="seat_class" name="SeatClass">
                                <option value="f">First Class</option>
                                <option value="b">Business Class</option>
                                <option value="e">Economy Class</option>
                            </select>
                        <div class="centerText">
                            <button class="reserve update">Update</button>
                        </div>
                        </form>
                    </div>
                    <div id="deleteTicket" class="hidden">
                        <h4>Delete Ticket:</h4>
                        <form action="ticketoperation?op=delete" method="post" id="deleteTicketForm">
                        <label for="f#">Flight Number:</label><input id="f#" type="text" name="flightNumber" />
                        <br/>
                        <label for="dd">Departure Date:</label><input id="dd" type="date" name="dDate" />
                        <br/>
                        <label for="sc">Seat Class:</label>
                        <select id="sc" name="seatClass">
                            <option value="f">First Class</option>
                            <option value="b">Business Class</option>
                            <option value="e">Economy Class</option>
                        </select>
                        <div class="centerText">
                            <button class="reserve delete">Delete</button>
                        </div>
                        </form>
                    </div>

                    <!--Flight insert, update, delete-->
                    <div id="insertFlight" class="hidden">
                    <h4>Add Flight:</h4>
                    <form action="flightoperation?op=insert" method="post" id="addFlightForm">
                      <div>
                        <label for="flightNum">Flight Number:</label><input id="flightNum" type="text" name="flightNumber" />
                        <br/>
                        <label for="acode">Airline Code:</label><input id="acode" type="text" name="airlineCode" />
                        <br/>
                        <label for="aircraft">Aircraft Model:</label><input id="aircraft" type="text" name="aircraftModel" />
                        <br/>
                        <label for="depart">Depart Airport Code:</label><input id="depart" type="text" name="departAirportCode" />
                        <br/>
                        <label for="arrive">Arrival Airport Code:</label><input id="arrive" type="text" name="arrivalAirportCode" />
                        <br/>
                        <label for="departTime">Departure Time:</label><input id="departTime" type="time" name="departureTime" />
                        <br/>
                        <label for="arriveTime">Arrival Time:</label><input id="arriveTime" type="time" name="arrivalTime" />
                        <br/>
                        <label for="overnight">Overnight:</label><input id="overnight" type="checkbox" name="overnight" value="yes"/>
                        <div class="centerText">
                            <button class="reserve insert">Add Flight</button>
                        </div>
                      </div>
                    </form>
                    </div>
                    <div id="updateFlight" class="hidden">
                        <h4>Update Flight:</h4>
                        <form action="flightoperation?op=update" method="post" id="updateFlightForm">
                        <label for="flightAttr">Attribute to update:</label>
                        <select id="flightAttr" name="flightAttribute">
                            <option value="aircraftModel">Aircraft Model</option>
                            <option value="departureTime">Departure Time</option>
                            <option value="arrivalTime">Arrival Time</option>
                        </select>
                        <br/>
                        <label for="aAttrVal">New Attribute Value:</label><input id="newAttrValue" name="newAttributeValue" type="text"/>
                        <br/>
                        <label for="flightNum">For flight number =</label><input type="text" id="flightNum" name="flightNumber" />
                        <div class="centerText">
                            <button class="reserve update">Update</button>
                        </div>
                        </form>    
                    </div>
                    <div id="deleteFlight" class="hidden">
                        <h4>Delete Flight:</h4>
                        <form action="flightoperation?op=delete" method="post" id="deleteFlightForm">
                        <label for="flightNum">Flight number:</label><input id="flightNum" type="text" name="flightNumber" /><button class="reserve delete">Delete</button>
                        </form>
                    </div>
                    

                    <!--Airport Insert, Update, Delete-->
                    <div id="insertAirport" class="hidden">
                        <h4>Add Airport:</h4>
                        <label for="AC">Airport Code:</label><input id="AC" type="text" name="airportCode" />
                        <br/>
                        <label for="AN">AirportName:</label><input id="AN" type="text" name="airportName" />
                        <br/>
                        <label for="ACity">Airport City:</label><input id="ACity" type="text" name="city" />
                        <br/>
                        <label for="ACountry">Airport Country:</label><input id="ACountry" type="text" name="country" />
                        <br/>
                        <div class="centerText">
                            <button class="reserve center insert">Add Airport</button>
                        </div>
                    </div>
                    <div id="updateAirport" class="hidden">
                        <h4>Update Airport</h4>
                        <label for="aattr">Attribute to update:</label>
                        <select id="aattr" name="airportAttribute">
                            <option value="airportCode">Airport code</option>
                            <option value="airportName">Airport Name</option>
                            <option value="city">Airport City</option>
                            <option value="country">Airport Country</option>
                        </select>
                        <br/>
                        <label for="aAttrVal">New Attribute Value:</label><input id="aAttrVal" name="airportAttributeValue" type="text"/>
                        <br/>
                        <label for="aCode">For airport code =</label><input type="text" id="aCode" name="airportCode" />
                        <div class="centerText">
                            <button class="reserve update">Update</button>
                        </div>
                    </div>
                    <div id="deleteAirport" class="hidden">
                        <h4>Delete Airport:</h4>
                        <label for="an">Airport Name:</label><input id="an" type="text" name="airportName" />
                        <button class="reserve delete">Delete</button>
                    </div>

                    <!--Airline Insert, Update, Delete -->
                    <div id="insertAirline" class="hidden">
                        <h4>Add Airline:</h4>
                        <label for="ALC">Airline Code:</label><input id="ALC" type="text" name="airlineCodeNumber" />
                        <br/>
                        <label for="ALN">Airline Name:</label><input id="ALN" type="text" name="airlineName" />
                        <div class="centerText">
                            <button class="reserve insert">Add Airline</button>
                        </div>
                    </div>
                    <div id="updateAirline" class="hidden">
                        <h4>Update Airline:</h4>
                        <label for="alattr">Attribute to update:</label>
                        <select id="alattr" name="airlineAttribute">
                            <option value="airlineCode">Airline code</option>
                            <option value="airlineName">Airline Name</option>
                        </select>
                        <br/>
                        <label for="alAttrVal">New Attribute Value:</label><input id="alAttrVal" name="alAttrVal" type="text"/>
                        <br/>
                        <label for="alCode">For airline code =</label><input type="text" id="alCode" name="airlineCode" />
                        <div class="centerText">
                            <button class="reserve update">Update</button>
                        </div>
                    </div>
                    <div id="deleteAirline" class="hidden">
                        <h4>Delete Airline:</h4>
                        <label for="alc">Airline Code:</label><input id="alc" type="text" name="alc" /><button class="reserve delete">Delete</button>
                    </div>

                    <!--Aircraft Insert, Update, Delete-->
                    <div id="insertAircraft" class="hidden">
                        <h4>Add Aircraft:</h4>
                        <label for="AM">Employee ID:</label><input id="AM" type="text" name="aircraftModel" />
                        <br/>
                        <label for="AFC">First Class Capacity:</label><input id="AFC" type="number" name="firstCapacity" />
                        <br/>
                        <label for="ABC">Business Class Capacity:</label><input id="ABC" type="number" name="businessCapacity" />
                        <br/>
                        <label for="AEC">Economy Class Capacity:</label><input id="AEC" type="number" name="economyCapacity" />
                        <br/>
                        <label for="AMP">Manufactured Place:</label><input id="AMP" type="text" name="manufacPlace" />
                        <br/>
                        <label for="AMD">Manufactured Date:</label><input id="AMD" type="date" name="manufacDate" />
                        <br/>
                        <div class="centerText">
                            <button id="iac"class="reserve insert">Add Aircraft</button>
                        </div>
                    </div>
                    <div id="updateAircraft" class="hidden">
                        <h4>Update Aircraft:</h4>
                        <label for="acattr">Attribute to update:</label>
                        <select id="acattr" name="aircraftAttribute">
                            <option value="aircraftModel">Model number</option>
                            <option value="firstCapacity">First Class Capacity</option>
                            <option value="businessCapacity">Business Class Capacity</option>
                            <option value="economyCapacity">Economy Class Capacity</option>
                            <option value="manufacPlace">Manufactured Place</option>
                            <option value="manufacDate">Manufactured Date</option>
                        </select>
                        <br/>
                        <label for="acAttrVal">New Attribute Value:</label><input id="acAttrVal" name="acAttrVal" type="text"/>
                        <br/>
                        <label for="amn">For aircraft model =</label><input type="text" id="amn" name="aircraftModelNumber" />
                        <div class="centerText">
                            <button class="reserve update">Update</button>
                        </div>
                    </div>
                    <div id="deleteAircraft" class="hidden">
                        <h4>Delete Aircraft:</h4>
                        <label for="am">Aircraft Model:</label><input id="am" type="text" name="aircraftModel" />
                        <button id="dac" class="reserve delete">Delete</button>
                    </div>


                </div>
                <div style="clear:both"></div>
            </div>
        </c:when>
        <c:when test="${param.show eq 'statistics'}">
            <!-- statistics container -->
            <div id="statistics">
                <div id="statMenu">
                    <ul id="statsOptions" class="center">
                        <li class="statOption">View flight number, departure date, and average age of passengers for all flights of a given airline.
                            <div class="hidden centerText">
                                <label for="aName">Airline Name:</label>
                                <input id="aName" type="text" name="airline_name" />
                                <button id="stat1" class="reserve">View Statistic</button>
                            </div>
                        </li>
                        <li class="statOption">View flight number of the most popular flight between given airports.
                            <div class="hidden centerText">
                                <label for="da">Departure Airport:</label><input id="da" type="text" name="depart_airport" />
                                <br/>
                                <label for="aa">Arrival Airport:</label><input id="aa" type="text" name="arrival_airport" />
                                <br/>
                                <button id="stat2" class="reserve">View Statistic</button>
                            </div>
                        </li>
                        <li class="statOption">View names and emails for all passengers of flight UA858.
                            <div class="hidden centerText"><button id="stat3" class="reserve">View statistic</button></div>
                        </li>
                        <li class="statOption">View all airlines with employees of an average age over a certain age.
                            <div class="hidden centerText">
                                <label for="inputAge">Average age:</label><input id="inputAge" type="text" name="average_age" />
                                <button id="stat4" class="reserve">View Statistic</button>
                            </div>
                        </li>
                        <li class="statOption">View the total revenue for a given airline on a given date.
                            <div class="hidden centerText">
                                <label for="inputAirline">Airline name:</label><input id="inputAirline" type="text" name="airline_name" />
                                <br/>
                                <label for="inputDate">Departure Date:</label><input id="inputDate" type="date" name="depart_date" />
                                <br/>
                                <button id="stat5" class="reserve">View statistic</button>
                            </div>
                        </li>
                        <li class="statOption">View the number of tickets for a given flight.
                            <div class="hidden centerText">
                                <label for="inputFlight">Flight number:</label><input id="inputFlight" type="text" name="flight_number" />
                                <button id="stat6" class="reserve">View statistic</button>
                            </div>
                        </li>
                        <li class="statOption">View the airport with the maximum number of departed flights.
                            <div class="hidden centerText"><button id="stat7" class="reserve">View statistic</button></div>
                        </li>
                        <li class="statOption">View the airline with the greatest number of passengers.
                            <div class="hidden centerText"><button id="stat8" class="reserve">View statistic</button></div>
                        </li>
                    </ul>
                </div>

                <!--Results of statistc viewing goes here-->
                <div id="statCommands" class="hidden">

                </div>
            </div>
        </c:when>
        <c:when test="${param.show eq 'archive'}">
            <!--archive message container-->
            <div id="archiveMessage">
              TODO: archive message shows here
            </div>
        </c:when>    
        </c:choose>
        </div>
    </div>    
    <script type="text/javascript">
        //display sub-menu lists on main list items hover
        $(".modOption").hover(function(){
            $(this).children("ul").show();
            $(this).children("div").addClass("blackTriangleDown");
        }, function(){
            $(this).children("ul").hide();
            $(this).children("div").removeClass("blackTriangleDown");
        });

        //handle click events for Employee update and delete options
        $("#UE").click(function(){
           $("modCommands").children().hide();
           $("#updateWage").show();
        });
        $("#DE").click(function(){
           $("#modCommands").children().hide();
           $("#deleteEmployee").show();
        });

        //handle click events for Ticket insert, update, and delete options
        $("#IT").click(function(){
           $("#modCommands").children().hide();
           $("#insertTicket").show();
        });
        $("#UT").click(function(){
           $("#modCommands").children().hide();
           $("#updateTicket").show();
        });
        $("#DT").click(function(){
           $("#modCommands").children().hide();
           $("#deleteTicket").show();
        });

        //handle click events for Flight insert, update, and delete options
        $("#IF").click(function(){
           $("#modCommands").children().hide();
           $("#insertFlight").show();
        });
        $("#UF").click(function(){
           $("#modCommands").children().hide();
           $("#updateFlight").show();
        });
        $("#DF").click(function(){
           $("#modCommands").children().hide();
           $("#deleteFlight").show();
        });

        //display messages for when insert, update, and delete buttons are clicked
        //YOU NEED TO ADD THE DATABASE FUNCTIONS HERE AND DISPLAY MESSAGE IF SUCCESSFUL
        /*
        $(".insert").click(function(){
           $("#modCommands").children().hide();
           $("#message").html("<h4>Message:</h4><p>Insert performed successfully.</p>").show();
        });
        $(".update").click(function(){
           $("#modCommands").children().hide();
           $("#message").html("<h4>Message:</h4><p>Update performed successfully.</p>").show();
        });
        $(".delete").click(function(){
           $("#modCommands").children().hide();
           $("#message").html("<h4>Message:</h4><p>Delete performed successfully.</p>").show();
        });
        */

        //handle hover event of statistic list items
        $(".statOption").click(function(){
            $(this).children("div").slideToggle();
        });

        $("#stat1").click(function(){
           $("#statCommands").html("<p>Stat 1 result here.</p>").show();
        });
        $("#stat2").click(function(){
           $("#statCommands").html("<p>Stat 2 result here.</p>").show();
        });
        $("#stat3").click(function(){
           $("#statCommands").html("<p>Stat 3 result here.</p>").show();
        });
        $("#stat4").click(function(){
           $("#statCommands").html("<p>Stat 4 result here.</p>").show();
        });
        $("#stat5").click(function(){
           $("#statCommands").html("<p>Stat 5 result here.</p>").show();
        });
        $("#stat6").click(function(){
           $("#statCommands").html("<p>Stat 6 result here.</p>").show();
        });
        $("#stat7").click(function(){
           $("#statCommands").html("<p>Stat 7 result here.</p>").show();
        });
        $("#stat8").click(function(){
           $("#statCommands").html("<p>Stat 8 result here.</p>").show();
        });
    </script>

</body>
</html>
