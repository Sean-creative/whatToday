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
	<!-- 채팅방 만들기 버튼은 개설자만 보일수 있도록 한다. / 한번만클릭해야함./ -->
	<button class = "btn btn-primary" id = "enter">채팅방만들기</button>
     <!--<button class = "btn btn-primary" id = "enter">입장</button>-->
     <!-- 닉네임입력후 확인눌러야 채팅 전송가능.. -->
   	<input type="text" id="nickname" class="form-inline" placeholder="닉네임을 입력해주세요(필수)" required autofocus>
    <button class = "btn btn-primary" id = "name">확인</button>
    <div id = "chatroom" style = "width:400px; height: 600px; border:1px solid; background-color : gray"></div>
    <input type = "text" id = "message" style = "height : 30px; width : 340px" placeholder="내용을 입력하세요" autofocus>
    <input type="hidden" id="cbNum" value="${cbNum }" placeholder="모임 번호"/>
    <button class = "btn btn-primary" id = "send">전송</button>
</body>
    <script>
        var webSocket;

        var cbNum= document.getElementById('cbNum').value;
        var nickname;
    	
   		
    	document.getElementById("enter").addEventListener("click", function(){
    		document.getElementById("enter").style.display="none";
    		connect();
    		onOpen();
    	})
    

        document.getElementById("name").addEventListener("click", function(){
            nickname = document.getElementById("nickname").value;
            document.getElementById("nickname").style.display="none";
            document.getElementById("name").style.display="none";
            connect();
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
            webSocket.close();
        }
        function send(){
        	let msg = document.getElementById("message").value;
        	
        	webSocket.send("채팅,"+cbNum+","+nickname+","+msg); //타겟, 내용.
        	
            document.getElementById("message").value = "";

        }
        function onOpen(){
        	webSocket.send("입장," + cbNum+","+nickname+",방만들기.");
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