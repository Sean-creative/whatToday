<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
td{
text-align:center;}
</style>
</head>

<body>

<h2>BOARD LIST</h2>

<table width="100%">
	<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<!-- <th>작성자</th> -->
			<th>작성일</th>
		</tr>
	</thead>
	<c:forEach items="${noticeContent}" var="notice">
		<tr>
			<td><c:out value="${notice.ntNum}" /></td>
			<td>
				<a href='<c:out value="${notice.ntNum }"/>'>
				<c:out value="${notice.ntTitle }" />
				</a>
			</td>
			<%-- <td><c:out value="${notice.ntTitle}" /></td> --%>
			<td><c:out value="${notice.ntDate}" /></td>
		</tr>
	</c:forEach>
</table>




</script>

</body>
</html>