<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Dashboard</title>
    <meta charset="UTF-8" />
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="css/EmployeeMain.css" />
</head>
<body>
    <div id="main" class="center">
        <div id="header">
            <h1>Employee Dashboard</h1>
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
                <li class="menuOption" id="ve"><a href="employeedashboard?show=viewEmployeeInfo">View contact info</a></li>
                <li class="menuOption" id="ee"><a href="employeedashboard?show=editEmployeeInfo">Edit contact info</a></li>
            </ul>
        </div>
        <div id="contentArea">
        <c:choose>
        <c:when test="${param.show eq 'viewEmployeeInfo'}">
            <div id="viewEmployeeInfo">
                <h2>Employee information</h2>
                <table id="einfo">
                    <tr>
                        <td class="employeeInfoLabel">
                            <span>First Name:</span>
                        </td>
                        <td class="employeeInfo">
                            <span id="efn" ><c:out value="${employee.firstName}" /></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="employeeInfoLabel">
                            <span >Middle Name:</span>
                        </td>
                        <td class="employeeInfo">
                            <span id="emn" ><c:out value="${employee.middleName}" /></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="employeeInfoLabel">
                            <span>Last Name:</span>
                        </td>
                        <td class="employeeInfo">
                            <span id="eln"><c:out value="${employee.lastName}" /></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="employeeInfoLabel">
                            <span>Airline:</span>
                        </td>
                        <td class="employeeInfo">
                            <span id="eal"><c:out value="${employee.airlineCode}" /></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="employeeInfoLabel">
                            <span>Wage:</span>
                        </td>
                        <td class="employeeInfo">
                            <span id="ewg"><c:out value="${employee.wage}" /></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="employeeInfoLabel">
                            <span>Email:</span>
                        </td>
                        <td class="employeeInfo">
                            <span id="eem" class="employeeInfo"><c:out value="${employee.email}" /></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="employeeInfoLabel">
                            <span>Phone:</span>
                        </td>
                        <td class="employeeInfo">
                            <span id="eph" ><c:out value="${employee.phone}" /></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="employeeInfoLabel">
                            <span>Street:</span>
                        </td>
                        <td class="employeeInfo">
                            <span id="est" ><c:out value="${employee.street}" /></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="employeeInfoLabel">
                            <span>City:</span>
                        </td>
                        <td class="employeeInfo">
                            <span id="ec" ><c:out value="${employee.city}" /></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="employeeInfoLabel">
                            <span>State:</span>
                        </td>
                        <td class="employeeInfo">
                            <span id="es"><c:out value="${employee.stateProvinceCounty}" /></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="employeeInfoLabel">
                            <span>Country:</span>
                        </td>
                        <td class="employeeInfo">
                            <span id="ec"><c:out value="${employee.country}" /></span>
                        </td>
                    </tr>
                </table>

            </div>
        </c:when>
        <c:when test="${param.show eq 'editEmployeeInfo'}">
            <div id="editEmployeeInfo">
            	<form action="editEmployeeInfo" method="post" id="editInfoForm">
                <h2>Edit Employee Information</h2>
                <p>Fields marked with <span class="required">*</span> are required. Password must be 8 or more characters and contain at least 1 letter and 1 digit.</p>
                <span id="eRegError" class="redText"></span>
                <div id="registerEmployee" class="register">
                    <span class="required">*</span><label for="ePassword">Password:</label><input id="ePassword" name="epassword" class="registerSpacing" type="password"/><br/>
                    <span class="required">*</span><label for="eFirstName">First Name:</label><input id="eFirstName" class="registerSpacing" name="efirstname" type="text"/><br/>
                    <label for="eMiddleName">Middle Name:</label><input id="eMiddleName" class="registerSpacing" name="emiddlename" type="text"/><br/>
                    <span class="required">*</span><label for="eLastName">Last Name:</label><input id="eLastName" class="registerSpacing" name="elastname" type="text"/><br/>
                    <span class="required">*</span><label for="eEmail">Email:</label><input id="eEmail" class="registerSpacing" name="eemail" type="email"/><br/>
                    <span class="required">*</span><label for="ePhone">Phone:</label><input id="ePhone" class="registerSpacing" name="ephone" type="text"/><br/>
                    <span class="required">*</span><label for="eStreet">Street:</label><input id="eStreet" class="registerSpacing" name="estreet" type="text"/><br/>
                    <span class="required">*</span><label for="eCity">City:</label><input id="eCity" class="registerSpacing" name="ecity" type="text"/><br/>
                    <span class="required">*</span><label for="eState">State:</label><input id="eState" class="registerSpacing" name="estate" type="text"/><br/>
                    <span class="required">*</span><label for="eCountry">Country:</label><input id="eCountry" class="registerSpacing" name="ecountry" type="text"/><br/>
                </div>
                <button id="eEditInfo" class="login">Submit</button>
                </form>
            </div>
        </c:when>
        </c:choose>
        </div>
        <script type="text/javascript">

        $("#ePassword").blur(function(){
            var pass = $("#ePassword").val();
            var passwordRegEx = /^(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9]{8,}/;
            if(!passwordRegEx.test(pass))
            {
                $("#eRegError").text("Invalid password.").show();
                $(this).focus();
            }
            else
            {
                $("#eRegError").hide();
            }
         });
         $("#eFirstName").blur(function(){
             var firstName = $(this).val();
             var firstNameRegEx=/^[a-zA-Z ]+$/;
             if(!firstNameRegEx.test(firstName))
             {
                 $("#eRegError").text("First name field is empty.").show();
                 $(this).focus();
             }
             else
             {
                 $("#eRegError").hide();
             }
         });
         $("#eLastName").blur(function(){
             var lastName = $(this).val();
             var lastNameRegEx=/^[a-zA-Z ]+$/;
             if(!lastNameRegEx.test(lastName))
             {
                 $("#eRegError").text("Last name field is empty.").show();
                 $(this).focus();
             }
             else
             {
                 $("#eRegError").hide();
             }
         });

         $("#eEmail").blur(function(){
            var email = $(this).val();
            var emailRegEx = /([\w\-]+\@[\w\-]+\.[\w\-]+)/;
            if(!emailRegEx.test(email))
            {
                 $("#eRegError").text("Invalid email address.").show();
                 $(this).focus();
            }
            else
             {
                 $("#eRegError").hide();
             }
         });
         /*
         $("#eEditInfo").click(function(){

             var pass = $("#ePassword").val();
             var passwordRegEx = /^(?=.*\a)(?=.*\d).{8,}/;
             var firstName = $("#eFirstName").val();
             var firstNameRegEx=/^[a-zA-Z ]+$/;
             var lastName = $("#eLastName").val();
             var lastNameRegEx=/^[a-zA-Z ]+$/;
             var email = $("#eEmail").val();
             var emailRegEx = /([\w\-]+\@[\w\-]+\.[\w\-]+)/;

             if(!passwordRegEx.test(pass))
             {
                 $("#eRegError").text("Invalid password.").show();
                 $("#ePassword").focus();
             }
             else if(!firstNameRegEx.test(firstName))
             {
                 $("#eRegError").text("First name field is empty.").show();
                 $(this).focus();
             }
             else if(!lastNameRegEx.test(lastName))
             {
                 $("#eRegError").text("Last name field is empty.").show();
                 $(this).focus();
             }
             else if(!emailRegEx.test(email))
             {
                 $("#eRegError").text("Invalid email address.").show();
                 $(this).focus();
             }
             $("#eUName, #ePassword, #eFirstName, #eMiddleName, #eLastName, #eBirthday, #eEmail, #eCity, #eState, #eCountry").val("");
             $("#infoEditSuccessful").text("Information edited successfully.").show();
             $("#editEmployeeInfo").hide();
         });

        $("#eEditInfo").click(function(){
            $("#infoEditSuccessful").text("Information edited successfully.").show();
            $("#editEmployeeInfo").hide();
        });
        */
            $("#eEditInfo").click(function(){
	           	$('#editInfoForm').submit();
            });
        </script>
    </div>
</body>
</html>
