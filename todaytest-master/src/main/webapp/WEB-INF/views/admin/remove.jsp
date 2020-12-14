<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>

<link rel="stylesheet" href="<c:url value='../resources/css/boardStyle2.css?after'/>">
<h1>remove</h1>

<form role="form" action="/admin/remove" method="post">
<div>
<label>번호</label>
<input type='text' name="ntNum" value='
	<c:out value="${notice.ntNum}" />' readonly="readonly"
	>
</div>

<div>
<label>제목</label>
<input type='text' name="ntTitle" value='
	<c:out value="${notice.ntTitle}" />'readonly="readonly"
	>
</div>

<div>
<label>내용</label>
<textarea name="ntContent">
 	<c:out value="${noticeContent[0].ntContent}" /> 
</textarea>
</div>

<div>
<label>날짜</label>
<input type='text' name="ntDate" value="${notice.ntDate}">
</div>

<input type='submit' data-oper='remove' class='btn btn-default' value="remove">

<!-- <input type=submit> -->
</form>
</body>
</html>