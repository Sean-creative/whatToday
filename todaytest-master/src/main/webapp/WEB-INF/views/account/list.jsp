<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<c:forEach var="member" items="${list}">
	<form action="/account/main" method="post">
    <button><c:out value="${member.usrId}"/></button>
    <input type="hidden" name = "usrId" value = '<c:out value="${member.usrId}"/>'>
    </form>
    <c:out value="${member.usrName}"/>
    <c:out value="${member.usrPhone}"/>
</c:forEach>




</body>
</html>