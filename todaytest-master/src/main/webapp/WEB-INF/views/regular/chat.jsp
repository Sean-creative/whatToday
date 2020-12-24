<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!-- 정기 모임 채팅창 (김지영) -->
<!-- 모임 가입한 사람만 채팅창 페이지에 들어올 수 있으며 채팅에 참여하려면 닉네임을 입력후 확인 버튼을 누르면 채팅창에 참여 할 수 있다. -->
<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" href="../resources/css/clubBoardStyle.css">
<link rel="stylesheet" href="../resources/css/regularChart.css">

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
			 <div>
				<div id=chatroom>
					<input type="hidden" id="cbNum" value="${cbNum }" placeholder="모임 번호" />
					<section class="msger">
						<header class="msger-header">
						<!-- 모임 개설자만 채팅방을 만들 수 있다. -->
						<c:if test="${usrNum eq cbLeaderNum }">
							<button id="enter">채팅방만들기</button>
						</c:if>
						<input type="text" id="nickname" class="form-inline" placeholder="닉네임을 입력해주세요(필수)" required autofocus>
						<button id="name">확인</button>
						<!--<div class="msger-header-title">
							<i class="fas fa-comment-alt"></i> ${cbName}
						</div>-->
						<div class="msger-header-options">
							<span><i class="fas fa-cog"></i></span>
						</div>
						</header>
						<br>
						<div class="msger-chat" id="chat"></div>
						
						<div class="msger-inputarea">
							<input type="text" class="msger-input" id="message" placeholder="Enter your message...">
							<button type="submit" class="msger-send-btn" id="send">Send</button>
						</div>
					</section>
				 </div><!-- END chatroom -->
				</div>
			</div>
			<div id="rightinfo" class="rightinfo">
                	<div class="content">
						<c:out value="${cbName}" />
                	</div>
            </div>
    </div>
</div>
<script>
	if("${msg }" != ""){
	 alert("${msg}");
    }
</script>
<script type="text/javascript">
$(document).ready(function() {
	var webSocket;
	
	var cbNum = document.getElementById('cbNum').value;
	var nickname;
	
	var mychat = document.getElementById("mychat");
	
	var enter = document.getElementById("enter");
	if(enter!=null){
		enter.addEventListener("click",function() {
			document.getElementById("enter").style.display = "none";
			connect();
			onOpen();
		});
	}
	document.getElementById("name").addEventListener("click",function() {
		nickname = document.getElementById("nickname").value;
		document.getElementById("nickname").style.display = "none";
		document.getElementById("name").style.display = "none";
		connect();
	});
	
	$('#send').click(function() {
		let message = document.getElementById("message").value;
		// 나
		$('#chat').append('<div class="msg right-msg"><div class="msg-bubble"><div class="msg-info"><div class="msg-info-name">나</div></div><div class="msg-text" id ="mytext">'+ message+ ' </div></div></div></div>');
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
		webSocket.send("채팅," + cbNum + "," + nickname + ","+ msg); //타겟, 내용.
		document.getElementById("message").value = "";
	}
	
	function onOpen() {
		webSocket.send("입장," + cbNum + "," + nickname + ",방만들기.");
	}

	function onMessage(e) {
		let data = e.data;
		let arr = data.split(":");
		let sender = arr[0];
		let msg = arr[1];
		console.log("sender:  " + sender);
		$('#chat').append('<div class="msg left-msg"><div class="msg-img" style="background-image: url(https://image.flaticon.com/icons/svg/145/145867.svg)"></div><div class="msg-bubble"><div class="msg-info"><div class="msg-info-name">'
							+ sender
							+ '</div></div><div class="msg-text">'
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
<%-- <%@include file="../includes/footer.jsp" %> --%>