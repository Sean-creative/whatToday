<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>

<link rel="stylesheet" href="<c:url value='../resources/css/boardStyle2.css?after'/>">

<div class="read">
<h1>notice read</h1>
</div>


<table class="tableread">
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

<button type="submit" data-oper='modify' class="btn btn-default">modify</button>
<!-- <button type="submit" data-oper='remove' class="btn btn-default">remove</button> -->
<button type="submit"data-oper='notice' class="btn btn-info">list</button>

<form id='operForm' action="/admin/modify" method="get">
<input type='hidden' id='ntNum' name='ntNum' value='<c:out value="${ntNum}"/> '>
</form>

<script src="http://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var operForm = $("#operForm");
	$("button[data-oper='modify']").on("click",function(e){
		operForm.attr("action","/admin/modify").submit();
	});
	
	$("button[data-oper='notice']").on("click",function(e){
		operForm.find("#ntNum").remove();
		operForm.attr("action","/admin/notice")
		operForm.submit();
	});
	
	/* var formObj = $("form");
	$('button').on("click",function(e){
		e.preventDefault();
		
		var operation = $(this).data("oper");
		console.log(operation);
		
		if(operation ==='remove'){
			(formObj.attr("action","/admin/notice");
		}else if(operation === 'notice'){
			self.location="/admin/notice";
			return;
		}
		formObj.submit();
	}); */
	
});
</script>
</body>
</html>