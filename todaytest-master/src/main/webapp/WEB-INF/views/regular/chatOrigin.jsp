<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<!-- 모임을 가입한 사람만 채팅창에 참여할 수 있음.  -->
<!-- 작성자 : 김지영 -->
<!DOCTYPE html>
<html>
<head>
<style>
:root {
  --msger-bg: #fff;
  --border: 2px solid #ddd;
  --left-msg-bg: #ececec;
  --right-msg-bg: #579ffb;
}

html {
  box-sizing: border-box;
}
.msger {
  display: flex;
  flex-flow: column wrap;
  justify-content: space-between;
  width: 100%;
  max-width: 867px;
  margin: 25px 10px;
  height: calc(100% - 50px);
  border: var(--border);
  border-radius: 5px;
  background: var(--msger-bg);
  box-shadow: 0 15px 15px -5px rgba(0, 0, 0, 0.2);
}

.msger-header {
  display: flex;
  justify-content: space-between;
  padding: 10px;
  border-bottom: var(--border);
  background: #eee;
  color: #666;
}

.msger-chat {
  flex: 1;
  overflow-y: auto;
  padding: 10px;
}
.msger-chat::-webkit-scrollbar {
  width: 6px;
}
.msger-chat::-webkit-scrollbar-track {
  background: #ddd;
}
.msger-chat::-webkit-scrollbar-thumb {
  background: #bdbdbd;
}
.msg {
  display: flex;
  align-items: flex-end;
  margin-bottom: 10px;
}
.msg:last-of-type {
  margin: 0;
}
.msg-img {
  width: 50px;
  height: 50px;
  margin-right: 10px;
  background: #ddd;
  background-repeat: no-repeat;
  background-position: center;
  background-size: cover;
  border-radius: 50%;
}
.msg-bubble {
  max-width: 450px;
  padding: 15px;
  border-radius: 15px;
  background: var(--left-msg-bg);
}
.msg-info {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
}
.msg-info-name {
  margin-right: 10px;
  font-weight: bold;
}
.msg-info-time {
  font-size: 0.85em;
}

.left-msg .msg-bubble {
  border-bottom-left-radius: 0;
}

.right-msg {
  flex-direction: row-reverse;
}
.right-msg .msg-bubble {
  background: var(--right-msg-bg);
  color: #fff;
  border-bottom-right-radius: 0;
}
.right-msg .msg-img {
  margin: 0 0 0 10px;
}

.msger-inputarea {
  display: flex;
  padding: 10px;
  border-top: var(--border);
  background: #eee;
}
.msger-inputarea * {
  padding: 10px;
  border: none;
  border-radius: 3px;
  font-size: 1em;
}
.msger-input {
  flex: 1;
  background: #ddd;
}
.msger-send-btn {
  margin-left: 10px;
  background: rgb(0, 196, 65);
  color: #fff;
  font-weight: bold;
  cursor: pointer;
  transition: background 0.23s;
}
.msger-send-btn:hover {
  background: rgb(0, 180, 50);
}

.msger-chat {
  background-color: #fcfcfe;
}
</style>

</head>
<body>
	<!-- START ##### 채팅창 (지영) ##### -->
	<div id=chatroom>
		<input type="hidden" id="cbNum" value="${cbNum }" placeholder="모임 번호" />
		<section class="msger">
			<header class="msger-header">
				<button id="enter">채팅방만들기</button>
				<input type="text" id="nickname" class="form-inline" placeholder="닉네임을 입력해주세요(필수)" required autofocus>
				<button id="name">확인</button>
				<div class="msger-header-title">
					<i class="fas fa-comment-alt"></i> 모임이름
				</div>
				<div class="msger-header-options">
					<span><i class="fas fa-cog"></i></span>
				</div>
			</header>

			<div class="msger-chat" id="chat"></div>
			<div class="msger-inputarea">
				<input type="text" class="msger-input" id="message" placeholder="Enter your message...">
				<button type="submit" class="msger-send-btn" id="send">Send</button>
			</div>
		</section>
	</div> <!-- END ##### 채팅창 (지영) ##### -->
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	var webSocket;
	
	var cbNum = document.getElementById('cbNum').value;
	var nickname;
	
	var mychat = document.getElementById("mychat");
	
	document.getElementById("enter").addEventListener("click",function() {
		document.getElementById("enter").style.display = "none";
		connect();
		onOpen();
	});
	
	document.getElementById("name").addEventListener("click",function() {
		nickname = document.getElementById("nickname").value;
		document.getElementById("nickname").style.display = "none";
		document.getElementById("name").style.display = "none";
		connect();
	});
	
	$('#send').click(function() {
		let message = document.getElementById("message").value;
		// 나
		$('#chat').append('<div class="msg right-msg"><div class="msg-img"style="background-image: url(https://image.flaticon.com/icons/svg/145/145867.svg)"></div><div class="msg-bubble"><div class="msg-info"><div class="msg-info-name">나</div></div><div class="msg-text" id ="mytext">'+ message+ ' </div></div></div></div>');
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
</html>