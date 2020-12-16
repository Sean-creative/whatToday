<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<!-- 모임을 가입한 사람만 채팅창에 참여할 수 있음.  -->
<!-- 작성자 : 김지영 -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>채팅 서비스</title>
    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
 
    <!-- 부가적인 테마 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
 
    <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 
 
</head>
<body>
    <button class = "btn btn-primary" id = "enter">입장</button>
    <div id = "chatroom" style = "width:400px; height: 600px; border:1px solid; background-color : gray"></div>
    <input type = "text" id = "message" style = "height : 30px; width : 340px" placeholder="내용을 입력하세요" autofocus>
    <input type="text" id="to" value="${cbNum }" placeholder="모임 번호"/>
    <button class = "btn btn-primary" id = "send">전송</button>
</body>
    <script>
        var webSocket;
        var nickname;
        document.getElementById("enter").addEventListener("click", function(){
        	if("${msg }" != ""){
    			alert("${msg}");
    			return false;
    		}else{
        		document.getElementById("enter").style.display="none";
            	connect();
    		}
        })
        document.getElementById("send").addEventListener("click",function(){
            send();
        })
        function connect(){
            webSocket = new WebSocket("ws://localhost:8080/echo");
            webSocket.onopen = onOpen;
            webSocket.onclose = onClose;
            webSocket.onmessage = onMessage;
        }
        function disconnect(){
            webSocket.send("${usrName} 님이 퇴장하셨습니다");
            webSocket.close();
        }
        function send(){
        	let message={};
            message.message = document.getElementById("message").value;
            message.to = document.getElementById("to").value;
            webSocket.send(JSON.stringify(message));
            
//            msg = document.getElementById("message").value;
//            webSocket.send("{${cbNum}} ${usrName} : " + msg);
            document.getElementById("message").value = "";
        }
        function onOpen(){
            webSocket.send("{${cbNum}} ${usrName} 님이 입장하셨습니다.");
        }
        function onMessage(e){
            data = e.data;
            chatroom = document.getElementById("chatroom");
            chatroom.innerHTML = chatroom.innerHTML + "<br>" + data;
        }
        function onClose(){
 
        }
    </script>
</html>