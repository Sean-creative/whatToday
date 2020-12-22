<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" href="../resources/css/clubBoardStyle.css">

<div id="bgpic">
	<div id="detail">
         <div id="leftinfo">
         	<img src="../resources/img/mount.jpg" alt="">
			<div id=banner>
				<ul>
					<li><a href="/regular/info?cbNum=<c:out value="${cbNum}" />">정보</a></li> <!--cbNum(모임번호)을 가지고 모임상세페이지이동-->
					<li><a href="javascript:void(0);">게시판</a></li> <!--a태그의 페이지이동 기능 무효화 -->
					<li><a href="/regular/chat?cbNum=<c:out value="${cbNum}" />">채팅</a></li>
				</ul>
			</div>
			<div id=bodymain>
			<table id="clubboard">
				<tr>
			  		<th>#번호</th>
			  		<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>  
				</tr>
				<c:forEach items="${list}" var="club">
				<tr>
					<td><c:out value="${club.cbBno}" /></td>
					<td>
					<a class='move' href='<c:out value="${club.cbBno }"/>'> 
					<c:out value="${club.cbBdTitle }" /></a>(${club.replyCount})</td>
					<td><c:out value="${club.cbBdWriter}" /></td>
					<td><c:out value="${club.cbBdDate}" /></td>
					<td><c:out value="${club.cbBdView}" /></td>
				</tr>
				</c:forEach>
			</table>
			
 		<button id="createBtn" type="button">글쓰기</button>
		
			<div class='pullright'>
				<ul class="pagination">
						
						<c:if test = "${pageMaker.prev }">
							<li class="paginate_button previous"><a href="${pageMaker.startPage -1}">Previous</a></li>
						</c:if>
						
						<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage}">
							<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active":""}"><a href="${num}">${num}</a></li>
						</c:forEach>	
						
						<c:if test="${pageMaker.next }">
							<li class="paginate_button next"><a href="${pageMaker.endPage +1}">Next</a></li>
						</c:if>						
					</ul>
			</div>
			</div> 
		</div>
		<div id="rightinfo" class="rightinfo">
                <div class="content">
					<c:out value="${cbName}" />
                </div>
        </div>
    </div>
</div>
			<!--  end Pagination --> 
		    <form id='actionForm' action="/regular/board" method='get'>
		    	<input type="hidden" id="cbNum" name="cbNum" value="<c:out value="${cbNum}" />"/>
				<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'>
				<input type='hidden' name='amount' value='${pageMaker.cri.amount }'>
			</form>		

<script type="text/javascript">
			
				$(document).ready(function() {

					let result = '<c:out value="${result}"/>';
					
						let actionForm = $("#actionForm");
						
						$(".paginate_button a").on("click", function(e) {
							
							e.preventDefault();
							
							console.log('click');
							
							actionForm.find("input[name='pageNum']").val($(this).attr("href"));
							actionForm.submit();
						});
						
						$("#createBtn").on("click", function() {
							
							self.location = "/regular/boardadd?cbNum=<c:out value="${cbNum}" />";
						});		
						
						$(".move").on("click", function(e) {
							e.preventDefault();
							actionForm.append("<input type='hidden' name='cbBno' value='" + $(this).attr("href")+"'>");
							actionForm.attr("action", "/regular/boardget");
							actionForm.submit();
							 
						});
				});
</script>

<script>
window.onscroll = function() {myFunction()};

var right = document.getElementById("rightinfo");
var sticky = rightinfo.offsetTop;

function myFunction() {
  if (window.pageYOffset > sticky) {
    rightinfo.classList.add("sticky");
  } else {
    rightinfo.classList.remove("sticky");
  }
}
</script>
<%-- <%@include file="../includes/footer.jsp" %> --%>