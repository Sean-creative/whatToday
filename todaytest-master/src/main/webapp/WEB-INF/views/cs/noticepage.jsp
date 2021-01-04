<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>

<link rel="stylesheet" href="<c:url value='../resources/css/read.css?after'/>">


<div id="readbg">
	<c:forEach items="${noticePage}" var="noticePage">
        <div class="primera">
            <div class="leff"><p>제목</p></div>
            <div class="rigg"><p><c:out value="${noticePage.ntTitle}" /></p></div>
        </div>
        <div class="primera">
            <div class="leff"><p>작성자</p></div>
            <div class="rigg"><p>오늘뭐하지</p></div>
        </div>
        <div class="segundo">
            <ul>
                <li><span class="espec">DATE</span> <span class="numero"><c:out value="${noticePage.ntDate}" /></span></li>
                <li><span class="espec">READ</span> <span class="numero"><c:out value="${noticePage.readCnt }"/></span></li>
            </ul>    
            <div class="noticont">
                <pre><c:out value="${noticePage.ntContent}" /></pre>
            </div>
        </div>
     </c:forEach>   
</div>
<div class="readpage">
	<button data-oper='list' class="btn btn-info">글 목록</button>
	<form id='operForm' action="/cs/notice" method="get">
		<input type='hidden' id='ntNum' name='ntNum' value='<c:out value="${notice.ntNum} "/>'>
		<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'/>
		<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'/>
	</form>
</div>

<script src="http://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		var operForm = $("#operForm");

		$("button[data-oper='list']").on("click",function(e) {
			 console.log($("#ntNum").val())
			operForm.find("#ntNum").remove(); 
			operForm.attr("action", '/cs/notice');
			operForm.submit();
		});
	});
</script>
<%@ include file="../includes/footer.jsp"%>
</body>
</html>