<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>

<link rel="stylesheet" href="<c:url value='../resources/css/boardStyle2.css?after'/>">

<h1>notice read</h1>


<table width="100%">
	<thead>
		<tr>
			<th>제목</th>
			<th>내용</th>
			
		</tr>
	</thead>
	<c:forEach items="${noticePage}" var="noticePage">
		<tr>
			<td><c:out value="${noticePage.ntTitle}" /></td>
			<td><c:out value="${noticePage.ntContent}" /></td>
		</tr>
	</c:forEach>
</table>
</body>
</html>