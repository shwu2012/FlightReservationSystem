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
        <c:when test="${param.show eq 'view'}">
            <!-- view container -->
            <div id="view">
                <div id="modMenu">
                <h3>View Selection:</h3>
                <ul id="modItems" class="menuItems">
                    <li class="modOption" onclick="$('#modCommands > div').hide(); $('#viewEmployee').show();">Employee</li>
                    <li class="modOption" onclick="$('#modCommands > div').hide(); $('#viewFlight').show();">Flight</li>
                    <li class="modOption" onclick="$('#modCommands > div').hide(); $('#viewTicket').show();">Ticket</li>
                </ul>
                </div>
                
                <div id="modCommands">
                    <!--Employee Delete-->
                    <div id="viewEmployee" class="hidden">
                        <h4>View Employee Information:</h4>
                        <form action="administratorview?view=employee" method="post" id="viewEmployeeForm">
                          <p>View information of all employees.</p>
                          <div class="centerText">
                            <button class="reserve">View</button>
                          </div>
                        </form>
                    </div>
                    <div id="viewFlight" class="hidden">
                        <h4>View Flight Information:</h4>
                        <form action="administratorview?view=flight" method="post" id="viewFlightForm">
                          <p>View information of all flights.</p>
                          <div class="centerText">
                            <button class="reserve">View</button>
                          </div>
                        </form>
                    </div>
                    <div id="viewTicket" class="hidden">
                        <h4>View Ticket Information:</h4>
                        <form action="administratorview?view=ticket" method="post" id="viewTicketForm">
                          <p>View all the tickets of a given flight number:</p>
                          <label for="flightNumber">Flight Number:</label>
                          <input id="flightNumber" type="text" name="flightNumber" />
                          <button class="reserve">View</button>
                        </form>
                    </div>
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
                            <form action="statistic?order=first" method="post" id="statisticFirstForm">
                                <label for="aName">Airline Name:</label>
                                <input id="aName" type="text" name="airline_name" />
                                <button id="stat1" class="reserve">View Statistic</button>
                            </form>
                            </div>
                        </li>
                        <li class="statOption">View flight number of the most popular flight between given airports.
                            <div class="hidden centerText">
                            <form action="statistic?order=second" method="post" id="statisticSecondForm">
                                <label for="da">Departure Airport Code:</label><input id="da" type="text" name="depart_airport" />
                                <br/>
                                <label for="aa">Arrival Airport Code:</label><input id="aa" type="text" name="arrival_airport" />
                                <br/>
                                <button id="stat2" class="reserve">View Statistic</button>
                            </form>
                            </div>
                        </li>
                        <li class="statOption">View names and emails for all passengers over a given age of a given flight.
                            <div class="hidden centerText">
                            <form action="statistic?order=third" method="post" id="statisticThirdForm">
                            	<label for="age">Age:</label>
                                <input id="age" type="text" name="age" />
                                <br/>
                                <label for="fNumber">Flight Number:</label>
                                <input id="fNumber" type="text" name="flight_number" />
                                <br/>
                                <button id="stat3" class="reserve">View statistic</button>
                            </form>
                            </div>
                        </li>
                        <li class="statOption">View all airlines with employees of an average age over a certain age.
                            <div class="hidden centerText">
                            <form action="statistic?order=fourth" method="post" id="statisticFourthForm">
                                <label for="inputAge">Average age:</label><input id="inputAge" type="text" name="average_age" />
                                <button id="stat4" class="reserve">View Statistic</button>
                            </form>
                            </div>
                        </li>
                        <li class="statOption">View the total revenue for a given airline on a given date.
                            <div class="hidden centerText">
                            <form action="statistic?order=fifth" method="post" id="statisticFifthForm">
                                <label for="inputAirline">Airline name:</label><input id="inputAirline" type="text" name="airline_name" />
                                <br/>
                                <label for="inputDate">Departure Date:</label><input id="inputDate" type="date" name="depart_date" />
                                <br/>
                                <button id="stat5" class="reserve">View statistic</button>
                            </form>
                            </div>
                        </li>
                        <li class="statOption">View the number of tickets for a given flight.
                            <div class="hidden centerText">
                            <form action="statistic?order=sixth" method="post" id="statisticSixthForm">
                                <label for="inputFlight">Flight number:</label><input id="inputFlight" type="text" name="flight_number" />
                                <button id="stat6" class="reserve">View statistic</button>
                            </form>
                            </div>                       
                        </li>
                        <li class="statOption">View the airport with the maximum number of departed flights.
                            <div class="hidden centerText">
                            <form action="statistic?order=seventh" method="post" id="statisticSeventhForm">
                                <button id="stat7" class="reserve">View statistic</button>
                            </form>
                            </div>
                        </li>
                        <li class="statOption">View the airline with the greatest number of passengers.
                            <div class="hidden centerText">
                            <form action="statistic?order=eighth" method="post" id="statisticEighthForm">
                                <button id="stat8" class="reserve">View statistic</button>
                            </form>
                            </div>
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
            <div id="archiveMessage" class="center">
              <form action="administratorarchive" method="post" id="archiveForm">
                <p>Archive reservations before the specified date.</p>
                <label for="archiveDate">Archive Date:</label><input type="date" id="archiveDate" name="archiveDate" />
                <label for="threshold">Threshold:</label>
                <select id="threshold" name="threshold">
                  <option value="5">5</option>
                  <option value="10">10</option>
                  <option value="15">15</option>
                  <option value="20">20</option>
                </select>
                <button class="reserve">Archive</button>
              </form>
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
           $("#modCommands").children().hide();
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

        //handle hover event of statistic list items
        $(".statOption").click(function(event){
          if (event.target.tagName != 'INPUT' && event.target.tagName != 'BUTTON') {
            $(this).children("div").slideToggle();
          }
        });
    </script>

</body>
</html>
