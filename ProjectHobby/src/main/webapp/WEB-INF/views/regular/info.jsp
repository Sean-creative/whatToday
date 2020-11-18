<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" href="../resources/css/clubInfoStyle.css">

	<div id="banner">
		<ul>
			<li><a href="javascript:void(0);">정보</a></li> 
			<li><a href="/regular/board?cbNum=<c:out value="${club.cbNum}" />">게시판</a></li>
			<li><a href="javascript:void(0);" onClick="alert('곧 오픈됩니다!'); return false;">채팅</a></li>
		</ul>
	</div>

	<div id="body">
		<div id=up>해시태그 - <c:out value="${club.cbHashtag}" /></div>
    	<div id=mid>[모임명]<c:out value="${club.cbName}" /></div>
    	<div id=dow><img src="/resources/img/clubsample.jpg" alt='sample' align="left">
    		한줄소개 - <c:out value="${club.cbIntro}" /><br>
    		상세내용 - <c:out value="${club.cbDetailContent}" /></div>	
	</div>

<%@include file="../includes/footer.jsp" %>