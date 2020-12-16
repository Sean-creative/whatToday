<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/resources/css/style.css">
    <title>Document</title>
</head>
<body>

<!-- Masthead-->
    <header id=header>

      <a href="/index/main">
        <img src="/resources/img/logo.png" alt="logo">
      </a>
      	<form action="/index/searchlist" method="get" onsubmit="return inputCheck()">
        <input type="text" placeholder="관심분야를 입력해주세요." name="subclass">
        </form>
        
        <sec:authorize access="isAnonymous()">
	        <ul class = "main">
	            <a href="/login/login">로그인</a>
	            <a href="/cs/faq">고객센터</a>
	        </ul>
        </sec:authorize>
        
        <!-- 로그인되면 보여지는 페이지 -->
        <sec:authorize access="isAuthenticated()">			
			<ul>
        		<a href ="/" id="user"><sec:authentication property="principal.user.usrName"/>님</a>
            	<a href="/login/logout">로그아웃</a>
            	
            	
            	<a href="/mypage/main">마이페이지</a>
           		<a href="/cs/faq">고객센터</a>
       	 	</ul>
				<div id="socketAlert" class="alert alert-success" role="alert" style="display:none;"></div>
		</sec:authorize>
		
<!-- Navigation-->
        <nav id="nav">
            <ul>
                <a href="">三</a>
                <a href="/regular/list">정기</a>
                <a href="/thunder/list">번개</a>
                <a href="">베스트</a>
                <a href="">추천</a>
                <div class="dropdown">모임개설
  					<div class="dropdown-content">
  						<a href="/regular/add">정기모임</a>
      					<a href="/thunder/add">번개모임</a>
  					</div>
				</div>
            </ul>
        </nav>
      </header>
<div id="wrap">
    <section id="#thunder_add">
    </section>

</div>

<script src="http://code.jquery.com/jquery-latest.js"></script>

<script type="text/javascript">
var socket = null;  //전역 변수로 선언

$(document).ready(function(){
	
	let loginCheck = null;
	
	<sec:authorize access="isAuthenticated()">			
		loginCheck = true
	</sec:authorize>
	if(loginCheck == true){
		connectWS();
	}
  
});

function connectWS(){

  var ws = new WebSocket("ws://localhost:8080/echo2/websocket");

  socket = ws;

  ws.onopen = function(message){

	  ws.send("My name is John");

  };

  ws.onmessage = function(event){

    $("#socketAlert").text(event.data);

    $("#socketAlert").css("display", "block");

  };

  ws.onclose = function(event){

    console.log("Server disConnect");

  };

  ws.onerror = function(event){

    console.log("Server Error");

  };
}
		var id = document.getElementById("user");
		console.log("userId: " +id);
		
		if(id != null){
			$(".main").css("display","none");
		}
		
		const inputCheck = function(){
			// 공백을 제거해한 뒤에 개수를 세던지 한다.
			let keyword = $.trim($("[name=keyword]").val());
			$('[name=keyword]').val(keyword);

			console.log(keyword.length);
			if (keyword.length > 30) {
				alert("키워드가 너무 깁니다 (30자 이하)");
				return false;
			}
		}
	
</script>

