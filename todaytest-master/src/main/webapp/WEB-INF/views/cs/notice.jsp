<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>

<link rel="stylesheet" href="<c:url value='../resources/css/notice.css?after'/>">

 <div class="s-visual">
		<div class="s-visual-in">
			<h2>공지사항</h2>
			<h4>NOTICE</h4>
		</div>
    </div>
    
    <div class="notimenu">
        <div class="notisubmenu">
            <a href="/cs/notice">공지사항 </a>
            <a href="/cs/faq">자주묻는질문 </a>
            <a href="/cs/inquire">문의사항 </a>
        </div>
    </div>

    <div id="table">
        <table>
            <tr>
              <th>분류</th>
              <th>제목</th>
              <th>날짜</th>
              <th>조회수</th>
            </tr>

            <c:forEach items="${noticeList}" var="notice">
			<tr>
				<td>공지</td>
				<td>
					<a href='/cs/noticepage?ntNum=<c:out value="${notice.ntNum }"/>'>
					<c:out value="${notice.ntTitle}" />
					</a>
				</td>
				<td><c:out value="${notice.ntDate}" /></td>
				<td><c:out value="${notice.readCnt }"/></td>
			</tr>
	</c:forEach>
        </table>    


<%-- 
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
			<th>조회수</th>
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
			<td><c:out value="${notice.readCnt }"/></td>
		</tr>
	</c:forEach>
</table> --%>


<!-- 페이지처리  -->
<div class='pull-right'>
	<ul class="pagination">
		<c:if test="${pageMaker.prev} ">
			<li class="paginate_button previous">
				<a href="${pageMaker.startPage-1 }">previous</a>
			</li>	
		</c:if>
		
		<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
		<li class="paginate_button">
			<a href="${num }">${num}</a>
		</li>
		</c:forEach>
		
		<c:if test="${pageMaker.next} ">
			<li class="paginate_button next">
				<a href="${pageMaker.endPage+1}">next</a>
		</c:if> 
	</ul>
</div>
<!--페이지 끝   -->
<form id='actionForm' action="/cs/notice" method='get'>
	<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
	<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>                 
</form>  
</div>

<script src="http://code.jquery.com/jquery-3.3.1.js"></script>
<script>
$(document).ready(function(){
	 
var actionForm = $("#actionForm");
	$(".paginate_button a").on( "click", function(e) {
	e.preventDefault();
	console.log('click');
	actionForm.find("input[name='pageNum']")
	.val($(this).attr("href"));
	actionForm.submit();
	});
$(".move").on("click",function(e){
	e.preventDefault();
	actionFrom.append("<input type='hidden' name='ntNum' value='"+$(this).attr("href")+"'>");
	actionFrom.attr("action","/cs/notice");
	actionForm.submit();
});	
  });   
</script>
</body>
</html>