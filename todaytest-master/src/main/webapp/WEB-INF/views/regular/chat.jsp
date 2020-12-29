<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!-- 정기 모임 채팅창 (김지영) -->
<!-- 모임 가입한 사람만 채팅창 페이지에 들어올 수 있으며 채팅에 참여하려면 닉네임을 입력후 확인 버튼을 누르면 채팅창에 참여 할 수 있다. -->
<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" href="../resources/css/clubBoardStyle.css">
<link rel="stylesheet" href="../resources/css/regularChat.css">

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
					<li><a href="/regular/board?cbNum=<c:out value="${club.cbNum}" />">게시판</a></li><!--cbNum(모임번호)을 가지고 게시판페이지이동-->
					<li><a href="javascript:void(0);">채팅</a></li>
				</ul>
			</div>
			<div id=chatroom>
				<input type="hidden" id="cbNum" value="${cbNum }" placeholder="모임 번호" />
				<section class="msger">
					<!-- 모임 개설자만 채팅방을 만들 수 있다. -->
					<div id ="makeChat">
						<button id="make"> + 모임 채팅방만들기 </button>
					</div>
					<div id = "enterChat">
						<input type="text" id="name" class="form-inline" placeholder="${usrName }" value="${usrName }" readonly="readonly">
						<button id="enter"> + 채팅창 들어가기</button>
					</div>
					
					<div class="msger-chat" id="chat">
					</div>
						
					<div class="msger-inputarea">
					<input type="text" class="msger-input" id="message" placeholder="메세지를 입력해주세요">
					<button type="submit" class="msger-send-btn" id="send">Send</button>
					</div>
				</section>
			</div><!-- END chatroom -->
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
<script>
	if("${msg }" != ""){
	 alert("${msg}");
    }
</script>
<script type="text/javascript">
$(document).ready(function() {
	var webSocket;
	
	var cbNum = document.getElementById('cbNum').value;
	var usrName ="${usrName}";
	var usrNum = "${usrNum}";
	var cbLeaderNum = "${club.cbLeaderNum}";	
	
	var make = document.getElementById("makeChat");
	var enter = document.getElementById("enterChat");

	// 모임 개설자만 채팅방을 개설 할 수 있다.
	if(usrNum==cbLeaderNum){
		make.style.display = "block";
	}
	// 모임 가입자는 채팅에 참여 할 수 있다.
	else{
		enter.style.display = "block";
	}
	
	// 모임 개설자도 모임 개설후 채팅에 입장 버튼을 클릭해야함.
	if(make!=null){
		make.addEventListener("click",function() {
			make.style.display = "none";
			enter.style.display = "block";
			connect();
			onOpen();
		});
	}
	
	// 입장버튼을 누르면 입장버튼 사라지게..
	enter.addEventListener("click",function() {
		enter.style.display = "none";
		connect();
	});
	
	$('#send').click(function() {
		let message = document.getElementById("message").value;
		// 나
		$('#chat').append('<div class="msg right-msg"><div class="msg-bubble"><div class="msg-text" id ="mytext">'+ message+ ' </div></div></div></div>');
		send();
	});
	
	function connect() {
		webSocket = new WebSocket("ws://localhost:8088/echo");
		webSocket.onopen = onOpen;
		webSocket.onclose = onClose;
		webSocket.onmessage = onMessage;
	}
	
	function disconnect() {
		webSocket.close();
	}
	
	function send() {
		let msg = document.getElementById("message").value;
		webSocket.send("입장," + cbNum + "," + usrName + ","+ msg); //타겟, 내용.
		document.getElementById("message").value = "";
	}
	
	function onOpen() {
		webSocket.send("개설," + cbNum + "," + usrName + ",방만들기.");
	}

	function onMessage(e) {
		let data = e.data;
		let arr = data.split(":");
		let sender = arr[0];
		let msg = arr[1];
		console.log("sender:  " + sender);
		$('#chat').append('<div class="msg left-msg"><div class="msg-img" style="background-image: url(https://image.flaticon.com/icons/svg/145/145867.svg)"></div><div id = "leftMsg"><div class="msg-info-name">'
							+ sender
							+ '</div><div class="msg-bubble"><div class="msg-text">'
							+ msg
							+ '</div></div></div>');
	}
	
	function onClose() {
	}

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