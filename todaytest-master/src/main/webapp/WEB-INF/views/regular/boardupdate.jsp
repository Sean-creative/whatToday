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
					<li><a href="/regular/board?cbNum=<c:out value="${cbNum}" />">게시판</a></li> <!--cbNum(모임번호)을 가지고 게시판페이지이동-->
					<li><a href="/regular/chat?cbNum=<c:out value="${cbNum}" />">채팅</a></li>
				</ul>
			</div>
		 <div id=bodymain>
		 <span class="half">글 수정</span>
		 		
		 <form id="formBoardUpdate" role="form" action="/regular/boardupdate" method="post">
			
			<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'/>
			<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'/>
			<input type="hidden" id="cbNum" name="cbNum" value='<c:out value="${cbNum}" />'/>
			
			<div class="form-group">
				<label>게시판 번호</label><br>
				<input type="text" class="form-control" name='cbBno' value = '<c:out value="${clubBoard.cbBno}"/>' readonly="readonly"/>
			</div>
			
			<div class="form-group">
				<label>제목</label><br> 
				<input type="text" class="form-control" name='cbBdTitle' value = '<c:out value="${clubBoard.cbBdTitle}"/>'/>
			</div>
			
			<div class="form-group">
				<label>작성자</label><br>
				<input type="text" class="form-control" name='cbBdWriter' value = '<c:out value="${clubBoard.cbBdWriter}"/>' readonly="readonly"/>
			</div>
			
			<div class="form-group">
				<label>내용</label><br>
				<textarea class="form-control" name='cbBdContent'><c:out value="${clubBoard.cbBdContent}"/></textarea>
			</div>
			
			<button type="submit" data-oper='update' class="btn btn">수정</button>
			<button type="submit" data-oper='delete' class="btn btn">삭제</button>
			<button type="submit" data-oper="list" class="btn btn">목록</button>
			
		</form>
			
		</div><!-- END bodymain -->
		</div><!-- END leftinfo -->
	
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
 
<script type="text/javascript">
	$(document).ready(function() {
		
		var formObj = $("#formBoardUpdate");
		$('button').on("click", function(e) {
			e.preventDefault();
			var operation = $(this).data("oper");
			
			console.log(operation);
			
			if (operation === 'delete') {
				
				formObj.attr("action", "/regular/boarddelete");
				
			} else if (operation === 'list') {
				
				formObj.attr("action", "/regular/board").attr("method", "get");
				var cbNumTag = $("input[name='cbNum']").clone();
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				
				formObj.empty();
				formObj.append(cbNumTag);
				formObj.append(pageNumTag);
				formObj.append(amountTag);
			}
			formObj.submit();
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