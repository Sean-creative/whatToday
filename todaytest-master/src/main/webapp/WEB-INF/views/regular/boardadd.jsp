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
			<span class="half">새글 쓰기</span>
			
			<form name="newadd" role="form" action="/regular/boardadd" method="post" onsubmit="return inputCheck();">
				
				<div class="form-group">
					<label>제목</label><br> 
					<input type="text" class="form-control" name='cbBdTitle' placeholder="제목을 입력해주세요.">
				</div>
				
				<div class="form-group">
					<label>작성자</label><br>
					<input type="text" class="form-control" name='cbBdWriter' value="<c:out value="${usrName}"/>" readonly="true">
				</div>
				
				<div class="form-group">
					<label>내용</label><br>
					<textarea class="form-control" name='cbBdContent' placeholder="내용을 입력해주세요."></textarea>
				</div>
				
				<div id="addbtn">
				<button type="submit" class="btn">등록</button>
				<button type="reset" class="btn">취소</button>
				</div>
				
				<input type="hidden" name="cbNum" value="${cbNum}"/>
			</form>
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
		
	</div>
 </div>

<script type="text/javascript">

	//유효성 검사 (빈문자열 체크, 글자 제한(30자이내로), 공백 제한 등)
	function inputCheck(){
		let title = document.newadd.cbBdTitle;
		
		if(!title.value || title.value.length > 30) {
			alert("제목을 입력해주세요.");
			return false;
		}
	}
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