<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Airline Reservation System</title>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="css/login.css" />
</head>

<body>
    <div id="main">
        <div id="header">
            <h1>Airline Reservation System</h1>
        </div>
        <div id="userType">
            <p id="loginHeader">Log in as:</p>
            <button id="passenger" class="primaryButton">Passenger</button>
            <button id="employee" class="primaryButton">Employee</button>
            <button id="administrator" class="primaryButton">Administrator</button>
            
            <p id="registerHeader">Not registered? Register as:</p>
            <button id="regPassenger" class="primaryButton">Passenger</button>
            <button id="regEmployee" class="primaryButton">Employee</button>
            
           
            <div id="passLogin" class="signIn <c:if test="${type ne 'passenger'}">hidden</c:if>">
                <h2>Passenger Sign In</h2>
                <form action="signin" method="post" id="passLoginForm">
                <p class="loginInstruction">Username and password both required. </p>
                <c:if test="${not empty passengerError}">
                  <span id="passLoginError" class="redText"><c:out value="${passengerError}" /></span><br/>
                </c:if>

                <label for="pUserName">Username:</label><input id="pUserName" class="signInSpacing signInInput" name="pusername" type="text"/>
                <br/>
                <label for="pPassWord">Password:</label><input id="pPassWord" class="signInSpacing signInInput" name="ppassword" type="password" />
                <br/>
                </form>
                <button id="pcancel" class="cancelButton signInSpacing">Cancel</button>
                <button id="plogin" class="login signInSpacing">Sign In</button>
            </div>
            <div id="employeeLogin" class="signIn <c:if test="${type ne 'employee'}">hidden</c:if>">
                <h2>Employee Sign In</h2>
                <form action="employeesignin" method="post" id="employeeLoginForm">
                <p class="loginInstruction">Username and password both required. </p>
                <c:if test="${not empty employeeError}">
                  <span id="employeeLoginError" class="redText"><c:out value="${employeeError}" /></span><br/>
                </c:if>
                
                <label for="eUserName">Username:</label><input id="eUserName" class="signInSpacing signInInput" name="eusername" type="text"/>
                <br/>
                <label for="ePassWord">Password:</label><input id="ePassWord" class="signInSpacing signInInput" name="epassword" type="password" />
                <br/>
                </form>
                <button id="ecancel" class="cancelButton signInSpacing">Cancel</button>
                <button id="elogin" class="login signInSpacing">Sign In</button>
           </div>
            <div id="adminLogin" class="signIn <c:if test="${type ne 'admin'}">hidden</c:if>">
                <h2>Administrator Sign In</h2>
                <form action="adminsignin" method="post" id="adminLoginForm">
                <p class="loginInstruction">Username and password both required. </p>
                <c:if test="${not empty adminError}">
                <span id="adminLoginError" class="redText"><c:out value="${adminError}" /></span><br/>
                </c:if>
                
                <label for="aUserName">Username:</label><input id="aUserName" class="signInSpacing signInInput" name="ausername" type="text"/>
                <br/>
                <label for="aPassWord">Password:</label><input id="aPassWord" class="signInSpacing signInInput" name="apassword" type="password" />
                <br/>
                </form>
                <button id="acancel" class="cancelButton signInSpacing">Cancel</button>
                <button id="alogin" class="login signInSpacing">Sign In</button>
            </div>
            
            <div id="registerPassenger" class="register <c:if test="${type ne 'registerPassenger'}">hidden</c:if>" >
                <h2>Passenger Registration</h2>
                <p>Fields marked with <span class="required">*</span> are required.  Username must only be characters a-z,A-Z,0-9.  Password must be 8 or more characters and contain at least 1 letter and 1 digit.</p>
                <span id="pRegError"></span>
                <br/>
                <div class="registerContainer">
                    <form action="register" method="post" id="passRegisterForm">
                    <c:if test="${not empty sqlError}">
                      <span id="passLoginError" class="redText"><c:out value="${sqlError}" /></span><br/>
                    </c:if>
                    <span class="required">*</span><label for="pUName">User Name:</label><input id="pUName" class="registerSpacing" name="puserName" type="text"/>
                    <br/>
                    <span class="required">*</span><label for="pPassword">Password:</label><input id="pPassword" name="ppassword" class="registerSpacing" type="password"/>
                    <br/>
                    <span class="required">*</span><label for="pFirstName">First Name:</label><input id="pFirstName" class="registerSpacing" name="pfirstName" type="text"/>
                    <br/>
                    <label for="pMiddleName">Middle Name:</label><input id="pMiddleName" class="registerSpacing" name="pmiddleName" type="text"/>
                    <br/>
                    <span class="required">*</span><label for="pLastName">Last Name:</label><input id="pLastName" class="registerSpacing" name="plastName" type="text"/>
                    <br/>
                    <span class="required">*</span><label for="pBirthDate">Birth date:</label><input id="pBirthDate" class="registerSpacing" name="pbirthDate" type="date"/>
                    <br/>
                    <label>Gender:</label><label for="pGenderM" id="pgm">M:</label><input type="radio" id="pGenderM" class="registerSpacing" name="pgender" value="M"/>
                    <label for="pGenderF">F:</label><input id="pGenderF" name="pgender" type="radio" value="F"/>
                    <br/>
                    <span class="required">*</span><label for="pEmail">Email:</label><input id="pEmail" class="registerSpacing" name="pemail" type="email"/>
                    <br/>
                    <label for="pPhone">Phone:</label><input id="pPhone" class="registerSpacing" name="pphone" type="text"/>
                    <br/>
                    <label for="pStreet">Street:</label><input id="pStreet" class="registerSpacing" name="pstreet" type="text"/>
                    <br/>
                    <label for="pCity">City:</label><input id="pCity" class="registerSpacing" name="pcity" type="text"/>
                    <br/>
                    <label for="pState">State:</label><input id="pState" class="registerSpacing" name="pstateProvinceCounty" type="text"/>
                    <br/>
                    <label for="pCountry">Country:</label><input id="pCountry" class="registerSpacing" name="pcountry" type="text"/>
                    <br/>
                    </form>
                    <button id="pRegCancel" class="cancelButton">Cancel</button>
                    <button id="pRegister" class="login">Register</button>
                </div>
            </div>
            
            <div id="registerEmployee" class="register <c:if test="${type ne 'registerEmployee'}">hidden</c:if>">
                <h2>Employee Registration</h2>
                <p>Fields marked with <span class="required">*</span> are required.  Username must only be characters a-z,A-Z,0-9.  Password must be 8 or more characters and contain at least 1 letter and 1 digit.</p>
                <span id="eRegError"></span>
                <div class="registerContainer">
                <form action="employeeregister" method="post" id="employeeRegisterForm">
                    <c:if test="${not empty sqlError}">
                      <span id="employeeLoginError" class="redText"><c:out value="${sqlError}" /></span><br/>
                    </c:if>
                    <span class="required">*</span><label for="eUName">User Name:</label><input id="eUName" class="registerSpacing" name="euserName" type="text"/>
                    <br/>
                    <span class="required">*</span><label for="ePassword">Password:</label><input id="ePassword" name="epassword" class="registerSpacing" type="password"/>
                    <br/>
                    <span class="required">*</span><label for="eFirstName">First Name:</label><input id="eFirstName" class="registerSpacing" name="efirstName" type="text"/>
                    <br/>
                    <label for="eMiddleName">Middle Name:</label><input id="eMiddleName" class="registerSpacing" name="emiddleName" type="text"/>
                    <br/>
                    <span class="required">*</span><label for="eLastName">Last Name:</label><input id="eLastName" class="registerSpacing" name="elastName" type="text"/>
                    <br/>
                    <span class="required">*</span><label for="eWage">Wage:</label><input id="eWage" class="registerSpacing" name="ewage" type="text"/>
                    <br/>
                    <span class="required">*</span><label for="eAirline">Airline:</label><input id="eAirline" class="registerSpacing" name="eairline" type="text"/>
                    <br/>
                    <span class="required">*</span><label for="eBirthday">Birth date:</label><input id="eBirthday" class="registerSpacing" name="ebirthDate" type="date"/>
                    <br/>
                    <span class="required">*</span><label>Gender:</label><label for="eGenderM" class="gm">M:</label><input type="radio" id="eGenderM" class="registerSpacing" name="egender" value="M"/><label for="eGenderF">F:</label><input id="eGenderF" name="eGender" type="radio" value="F"/>
                    <br/>
                    <span class="required">*</span><label for="eEmail">Email:</label><input id="eEmail" class="registerSpacing" name="eemail" type="email"/>
                    <br/>
                    <span class="required">*</span><label for="ePhone">Phone:</label><input id="ePhone" class="registerSpacing" name="ephone" type="text"/>
                    <br/>
                    <span class="required">*</span><label for="eStreet">Street:</label><input id="eStreet" class="registerSpacing" name="estreet" type="text"/>
                    <br/>
                    <span class="required">*</span><label for="eCity">City:</label><input id="eCity" class="registerSpacing" name="ecity" type="text"/>
                    <br/>
                    <span class="required">*</span><label for="eState">State:</label><input id="eState" class="registerSpacing" name="estateProvinceCounty" type="text"/>
                    <br/>
                    <span class="required">*</span><label for="eCountry">Country:</label><input id="eCountry" class="registerSpacing" name="ecountry" type="text"/>
                    <br/>
                    </form>
                    <button id="eRegCancel" class="cancelButton">Cancel</button>
                    <button id="eRegister" class="login">Register</button>
                </div>
            </div>
            
        </div>
    </div>
    <script type="text/javascript">
        //show login windows
        $("#passenger").click(function(){
            $("#passLogin").show();
        });
        $("#administrator").click(function(){
            $("#adminLogin").show();
        });
        $("#employee").click(function() {
            $("#employeeLogin").show(); 
        });
        
        //cancel login windows
        $("#pcancel").click(function(){
        	$("#passLogin").hide();
            $("#passLoginError").hide();
            $("#pUserName").val('');
            $("#pPassWord").val('');
        });
        $("#acancel").click(function(){
            $("#adminLogin").hide();
            $("#adminLoginError").hide();
            $("#aUserName").val('');
            $("#aPassWord").val('');
        });
        $("#ecancel").click(function(){
            $("#employeeLogin").hide();
            $("#employeeLoginError").hide();
            $("#eUserName").val('');
            $("#ePassWord").val('');
        });
        
        //handle login buttons click
        $("#plogin").click(function(){
        	$("#passLoginForm").submit();
        });
        $("#elogin").click(function(){
        	$("#employeeLoginForm").submit();
        });
        $("#alogin").click(function(){
        	$("#adminLoginForm").submit();
        });
        
        //register a passenger
        $("#regPassenger").click(function(){
            $("#registerPassenger").show(); 
        });
        $("#pUName").blur(function(){
            var userName = $(this).val();
            var userNameRegEx=/^[a-zA-Z0-9]+$/;
            if(!userNameRegEx.exec(userName))
            {
                $("#pRegError").text("Username field is empty or invalid.").show();
                $(this).focus();
            }
            else
            {
                $("#pRegError").hide();
            }
        });
        $("#pPassword").blur(function(){
            var pass = $("#pPassword").val();
            var passwordRegEx = /^(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9]{8,}/;
            if(!passwordRegEx.test(pass))
            {
                $("#pRegError").text("Invalid password.").show();
                $(this).focus();
            }
            else
            {
                $("#pRegError").hide();
            }
        });
        $("#pFirstName").blur(function(){
            var firstName = $(this).val();
            var firstNameRegEx=/^[a-zA-Z ]+$/;
            if(!firstNameRegEx.exec(firstName))
            {
                $("#pRegError").text("First name field is empty.").show();
                $(this).focus();
            }
            else
            {
                $("#pRegError").hide();
            }
        });
        $("#pLastName").blur(function(){
            var lastName = $(this).val();
            var lastNameRegEx=/^[a-zA-Z ]+$/;
            if(!lastNameRegEx.exec(lastName))
            {
                $("#pRegError").text("Last name field is empty.").show();
                $(this).focus();
            }
            else
            {
                $("#pRegError").hide();
            }
        });
        $("#pBirthDate").blur(function(){
            var bday = $(this).val();
            var bdayRegEx = /^[0-9-]+$/;
            if(!bdayRegEx.exec(bday))
            {
                $("#pRegError").text("Invalid birthday field.").show();
                $(this).focus();
            }
            else
            {
                $("#pRegError").hide();
            }
        });
        $("#pEmail").blur(function(){
           var email = $(this).val();
           var emailRegEx = /([\w\-]+\@[\w\-]+\.[\w\-]+)/;
           if(!emailRegEx.exec(email))
           {
                $("#pRegError").text("Invalid email address.").show();
                $(this).focus();
           }
           else
            {
                $("#pRegError").hide();
            }
        });
        $("#pRegister").click(function(){
            var userName = $("#pUName").val();
            var userNameRegEx=/^[a-zA-Z0-9]+$/;
            var pass = $("#pPassword").val();
            var passwordRegEx = /^(?=.*\a)(?=.*\d).{8,}/;
            var firstName = $("#pFirstName").val();
            var firstNameRegEx=/^[a-zA-Z ]+$/;
            var lastName = $("#pLastName").val();
            var lastNameRegEx=/^[a-zA-Z ]+$/;
            var bday = $("#pBirthDate").val();
            var bdayRegEx = /^[0-9-]+$/;
            var email = $("#pEmail").val();
            var emailRegEx = /([\w\-]+\@[\w\-]+\.[\w\-]+)/;
            
            if (!userNameRegEx.test(userName)) {
                $("#pRegError").text("Username is empty.").show();
                $("#pUName").focus();
                return;
            } else if (!passwordRegEx.test(pass)) {
                $("#pRegError").text("Invalid password.").show();
                $("#pPassword").focus();
                return;
            } else if (!firstNameRegEx.test(firstName)) {
                $("#pRegError").text("First name field is empty.").show();
                $(this).focus();
                return;
            } else if(!lastNameRegEx.test(lastName)) {
                $("#pRegError").text("Last name field is empty.").show();
                $(this).focus();
                return;
            } else if(!bdayRegEx.test(bday)) {
                $("#pRegError").text("Empty birthday field.").show();
                $(this).focus();
                return;
            } else if(!emailRegEx.test(email)) {
                $("#pRegError").text("Invalid email address.").show();
                $(this).focus();
                return;
            }
            //$("#pUName, #pPassword, #pFirstName, #pMiddleName, #pLastName, #pBirthDate, #pEmail, #pCity, #pState, #pCountry").val("");
            $('#passRegisterForm').submit();
        });
        $("#pRegCancel").click(function() {
            $("#registerPassenger").hide();
            $("#pUName, #pPassword, #pFirstName, #pMiddleName, #pLastName, #pBirthday, #pEmail, #pCity, #pState, #pCountry").val("");
        });
        
        //handle employee registration
        $("#regEmployee").click(function(){
           $("#registerEmployee").show(); 
        });
        $("#eUName").blur(function(){
            var userName = $(this).val();
            var userNameRegEx=/^[a-zA-Z0-9]+$/;
            if(!userNameRegEx.exec(userName))
            {
                $("#eRegError").text("Username field is empty or invalid.").show();
                $(this).focus();
            }
            else
            {
                $("#eRegError").hide();
            }
        });
        $("#ePassword").blur(function(){
            var pass = $(this).val();
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
            if(!firstNameRegEx.exec(firstName))
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
            if(!lastNameRegEx.exec(lastName))
            {
                $("#eRegError").text("Last name field is empty.").show();
                $(this).focus();
            }
            else
            {
                $("#eRegError").hide();
            }
        });
        $("#eBirthday").blur(function(){
            var bday = $(this).val();
            var bdayRegEx = /^[0-9-]+$/;
            if(!bdayRegEx.test(bday))
            {
                $("#eRegError").text("Invalid birthday field.").show();
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
           if(!emailRegEx.exec(email))
           {
                $("#eRegError").text("Invalid email address.").show();
                $(this).focus();
           }
           else
            {
                $("#eRegError").hide();
            }
        });
        $("#eRegister").click(function(){
            var userName = $("#eUName").val();
            var userNameRegEx=/^[a-zA-Z0-9]+$/;            
            var pass = $("#ePassword").val();
            var passwordRegEx = /^(?=.*\a)(?=.*\d).{8,}/;
            var firstName = $("#eFirstName").val();
            var firstNameRegEx=/^[a-zA-Z ]+$/;
            var lastName = $("#eLastName").val();
            var lastNameRegEx=/^[a-zA-Z ]+$/;
            var bday = $("#eBirthday").val();
            var bdayRegEx = /^[0-9-]+$/;
            var email = $("#eEmail").val();
            var emailRegEx = /([\w\-]+\@[\w\-]+\.[\w\-]+)/;
            
            if(!userNameRegEx.exec(userName))
            {
                $("#eRegError").text("Username is empty.").show();
                $("#eUName").focus();
            }
            if(!passwordRegEx.test(pass))
            {
                $("#eRegError").text("Invalid password.").show();
                $("#ePassword").focus();
            }
            else if(!firstNameRegEx.exec(firstName))
            {
                $("#eRegError").text("First name field is empty.").show();
                $(this).focus();
            }
            else if(!lastNameRegEx.exec(lastName))
            {
                $("#eRegError").text("Last name field is empty.").show();
                $(this).focus();
            }
            else if(!bdayRegEx.test(bday))
            {
                $("#eRegError").text("Empty birthday field.").show();
                $(this).focus();
            }
            else if(!emailRegEx.exec(email))
            {
                $("#eRegError").text("Invalid email address.").show();
                $(this).focus();
            }
            //$("#eUName, #ePassword, #eFirstName, #eMiddleName, #eLastName, #eBirthday, #eEmail, #eCity, #eState, #eCountry").val("");
            
            $('#employeeRegisterForm').submit();
        });
        $("#eRegCancel").click(function(){
           $("#registerEmployee").hide();
           $("#eUName, #ePassword, #eFirstName, #eMiddleName, #eLastName, #eBirthday, #eEmail, #eCity, #eState, #eCountry").val("");
        });
        $("#plogin").click(function(){
        	$('#passLoginForm').submit();
        });	
        $("#elogin").click(function(){
        	$('#employeeLoginForm').submit();
        });	
        $("#alogin").click(function(){
        	$('#adminLoginForm').submit();
        });
    </script>
</body>
</html>
