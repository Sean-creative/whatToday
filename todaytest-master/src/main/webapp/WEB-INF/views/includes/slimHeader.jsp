<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="/resources/css/header.css">
<title>Document</title>
</head>
<body>
	<div id="header">
		<div id="head">
			<div class="menu1">
				<a href="/index/main"> <img src="/resources/img/logo.png"
					alt="logo"></a>
				<form action="/index/searchlist" method="get"
					onsubmit="return inputCheckMain()">
					<input type="text" name="search" placeholder="관심분야를 입력해주세요:)">
				</form>
			</div>
			<sec:authorize access="isAnonymous()">
				<div class="menu2">
					<li><a href="/login/login">로그인</a></li>
					<li><a href="/cs/faq">고객센터</a></li>
				</div>
			</sec:authorize>

			<!-- 로그인되면 보여지는 메뉴 -->
			<sec:authorize access="isAuthenticated()">
				<div class="menu2">
					<li><a href="/mypage/main" id="user"><sec:authentication property="principal.user.usrName" />님</a></li> 	
					<li>
					<div class="tooltip">
					<img id="alram" src="/resources/img/bell.png" alt="bell" style="width: 20px; height: 20px; margin: 10px 5px 0px 0px;">
					<div class="tooltiptext">
					<div id="socketAlert" class="alert alert-success" role="alert"></div>
						</div>
						</div>
						</li>
					<li><a href="/login/logout">로그아웃</a></li>
					<li><a href="/cs/faq">고객센터</a></li>
					
				</div>
			</sec:authorize>
		</div>
	</div>



<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
var socket = null;  //전역 변수로 선언
$(document).ready(function() {
	let msgId;
	let loginCheck = null;
	<sec:authorize access="isAuthenticated()">
	loginCheck = true;
	msgNum = <sec:authentication property="principal.user.usrNum"/>;
	</sec:authorize>
	if(loginCheck == true){
		connectWS(msgNum);
		}
	$("#alram").on("click",function(){
		$(".tooltiptext").toggle();
		
	})
	});
	
function myFunction() {
    document.getElementById("myDropdown").classList.toggle("show");
  //   document.getElementById("myDropdown").classList.toggle("hide");
  }
  function closeNav() {
  document.getElementById("myDropdown").classList.toggle("hide");
  }
  window.onclick = function(event) {
    if (!event.target.matches('.dropbtn')) {
      var dropdowns = document.getElementsByClassName("dropdown-content");
      var i;
      for (i = 0; i < dropdowns.length; i++) {
        var openDropdown = dropdowns[i];
        if (openDropdown.classList.contains('show')) {
          openDropdown.classList.remove('show');
        }
      }
    }
  }
//ver2
function openNav() {
document.getElementById("myNav").style.height = "100%";
}

function closeNav() {
document.getElementById("myNav").style.height = "0%";
}

function openMix(evt, cityName) {
var i, tabcontent, tablinks;
tabcontent = document.getElementsByClassName("tabcontent");
for (i = 0; i < tabcontent.length; i++) {
tabcontent[i].style.display = "none";
}
tablinks = document.getElementsByClassName("tablinks");
for (i = 0; i < tablinks.length; i++) {
tablinks[i].className = tablinks[i].className.replace(" active", "");
}
document.getElementById(cityName).style.display = "block";
evt.currentTarget.className += " active";
}
document.getElementById("defaultOpen").click();

function connectWS(msgNum){

var ws = new WebSocket("ws://localhost:8080/echo2/websocket");

socket = ws;
let Num = msgNum;
ws.onopen = function(message){
  
  ws.send(Num);
};

ws.onmessage = function(event){
console.log(event.data);
$("#socketAlert").prepend(event.data);

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
		

		const inputCheckMain = function(){

			// 공백을 제거해한 뒤에 개수를 세던지 한다.
			let keyword = $.trim($("[name=keyword]").val());
			$('[name=keyword]').val(keyword);

			console.log(keyword.length);
			if (keyword.length > 30) {
				alert("키워드가 너무 깁니다 (30자 이하)");
				return false;
			}


		};
</script>