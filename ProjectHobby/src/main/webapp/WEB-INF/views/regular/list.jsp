<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" href="../resources/css/clubListStyle.css">

<div id="body">
	<c:forEach items="${clublist}" var="club" varStatus="status" begin="0" end="19">
		<div class="box">
			<ul class="demo">
				<li>모임명:<a href='/regular/info?cbNum=<c:out value="${club.cbNum}" />'>
						<c:out value="${club.cbName}" /></a></li>
				<li>지역:<c:out value="${club.cbDistrict}" /></li>
				<li>현재인원:<c:out value="${club.cbCurMbNum}" /></li>
			</ul>
		</div>
	</c:forEach>
</div>

<%@include file="../includes/footer.jsp" %>