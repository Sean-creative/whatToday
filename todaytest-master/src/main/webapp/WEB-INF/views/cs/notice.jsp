<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>

<link rel="stylesheet" href="<c:url value='../resources/css/boardStyle2.css?after'/>">

<div class="ntc">
<div class="bcoran">
	<a href="/cs/faq">자주묻는질문 </a>
	<a href="/cs/inquire">1:1 문의사항  </a>
	<a href="/cs/notice">공지사항</a>
</div>

<h2>공지사항입니다.</h2>

<table width="100%">
	<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성일</th>
		</tr>
	</thead>
	<c:forEach items="${noticeList}" var="notice">
		<tr>
			<td><c:out value="${notice.ntNum}" /></td>
			<td>
				<a href='/cs/noticepage?ntNum=<c:out value="${notice.ntNum }"/>'>
				<c:out value="${notice.ntTitle}" />
				</a>
			</td>
			<td><c:out value="${notice.ntDate}" /></td>
		</tr>
	</c:forEach>
</table>
</div>

</body>
</html>