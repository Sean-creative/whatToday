<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" href="../resources/css/clubBoardStyle.css">

<div id="regularBoard">
	<div id="detail">
         <div id="leftinfo">
         	<div>
            	<p id="topInfo">#${club.cbSubcat} #${club.cbDistrict}</p>
            </div>
            <div>
            	<p id="topcbName">${club.cbIntro}, ${club.cbName}</p>         
            </div>
         	<img src="${cbThumbImg}" alt="">
			<div id=banner>
				<ul>
					<li><a href="/regular/info?cbNum=<c:out value="${cbNum}" />">정보</a></li> <!--cbNum(모임번호)을 가지고 모임상세페이지이동-->
					<li><a href="javascript:void(0);">게시판</a></li> <!--a태그의 페이지이동 기능 무효화 -->
					<li><a href="/regular/chat?cbNum=<c:out value="${cbNum}" />">채팅</a></li>
				</ul>
			</div>
			<div id=bodymain>
			<table id="clubboard">
				<tr id ="tHead">
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
					<a class='move' style="color: black;"href='<c:out value="${club.cbBno }"/>'> 
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
			</div><!-- END pullright -->
			</div><!-- END bodymain --> 
		</div><!-- END leftInfo -->
<div id="rightinfo" class="rightinfo">
            <div class="contentup">
                <div class="contentl">
                   <p>만남 일정</p>
                </div>
                <div class="contentr">
               <!-- 로그인 유저가 모임장이면 만남 추가 버튼을 보여준다 -->
               <c:if test="${usrNum == club.cbLeaderNum}">
                  <button class="btn-meeting" data-oper='addMeeting'>만남 추가</button>
               </c:if>
            </div>
                </div>
                <div style="margin: 0 10px">
                <div class="contentmid">
                   
                  <form action="#" method="get" id="meeting-form">
               <%-- <c:choose>
                        <c:when test="${ClubMemberVO.usrNum == clubVO.cbLeaderNum}">모임장</c:when>
                        <c:otherwise>모임원</c:otherwise>
               </c:choose> --%>
               <c:forEach items="${meetingList}" var="MeetingVO">
                     <p id = "meetingName">🔸 ${MeetingVO.mtName} (${MeetingVO.mtCurMbNum}/${MeetingVO.mtMbNum}명)</p>
			               <button class="btn-meeting" data-oper='joinMeeting' value="${MeetingVO.mtNum}">
			                  <c:choose>
			                     <c:when test="${MeetingVO.usrMtState eq '참석중'}">참석 취소</c:when>
			                     <c:when test="${MeetingVO.usrMtState eq '미참석' || MeetingVO.usrMtState==null || MeetingVO.usrMtState eq '모임탈퇴'}">참석</c:when>
			                  </c:choose>
			               </button>
                     
                     <fmt:parseDate var="dateString" value="${MeetingVO.mtStartDate}" pattern="yyyy-MM-dd'T'HH:mm" />
                     <p>🔸 <fmt:formatDate value="${dateString}" pattern="M월 d일  E'요일' a h시  m분 " /></p>
                     
                    <p>🔸 ${MeetingVO.mtAddress} ${MeetingVO.mtPlace}</p>
                     
                     <p>🔸 ${MeetingVO.mtSupplies}</p>
               
               <hr width="100%" style="margin: 10px">
         
               </c:forEach>
               <input type="hidden" name="cbNum" value="<c:out value="${club.cbNum}" />" />
               <input type="hidden" name="cbName" value="${club.cbName }" />
               </form>
                </div>      
                </div>      
        </div> <!-- rightinfo END -->
        </div><!-- END detail -->
    </div><!-- END regularBoard -->
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
<%@include file="../includes/footer.jsp" %>