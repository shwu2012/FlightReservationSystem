<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register Page</title>
</head>
<body>
	<p>We got "msg" from servlet! <c:out value="${msg}"/></p>
	<p>We got "flight" from servlet! id=<c:out value="${flight.id}"/>, model=<c:out value="${flight.model}"/></p>
	<p>We didn't get "warning" from servlet! <c:out value="${warning}">no warning...</c:out></p>
</body>
</html>