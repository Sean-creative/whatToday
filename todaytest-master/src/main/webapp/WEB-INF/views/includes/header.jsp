<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"> 
<link rel="stylesheet" type="text/css" href="/resources/css/header.css">
<title>Document</title>
</head>
<body>
   <!--TOP버튼-->
   <div class="top_btn">
      <a href="#"><i class="material-icons">keyboard_arrow_up</i></a>
   </div>
   <div id="header">
      <div id="head">
         <div class="menu1">
            <a href="/index/main">
               <img src="/resources/img/logo.png" alt="logo">
            </a>
            <form action="/index/searchlist" method="get" onsubmit="return inputCheckMain()">
               <input id="serchHeader" type="text" name="headerKeyword" placeholder="관심분야를 입력해주세요:)" value='<c:out value="${cri.headerKeyword}" />'>
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
               <li><a href="/mypage/main" id="user">
                     <sec:authentication property="principal.user.usrName" />
                     님
                  </a></li>
               <li>
                  <div class="tooltip">
                     <img id="alram" src="/resources/img/bell.png" alt="bell" style="width: 20px; height: 20px; margin: 10px 5px 0px 0px;">
                     <div class="tooltiptext">
                         <div id="socketAlert" class="alert alert-success" role="alert"></div>
                     </div>
               </li>
               <li><a href="/login/logout">로그아웃</a></li>
               <li><a href="/cs/faq">고객센터</a></li>

            </div>
         </sec:authorize>
      </div>
      <div id="nav">
         <div class="submenudropdown">
            <button onclick="myFunction()" class="dropbtnr" onFocus="this.blur()">&#9776;</button>
            <div id="myDropdown" class="dropdown-contentr">
              <div class="dropreg">
                <div class="regtim">
                  <span class="togreg">정기모임 카테고리</span>
                    <ul class="tunder">
                      <a href="/regular/list?category=아웃도어%2F여행&subclass=모임+선택&city=지역+선택&district=세부지역+선택&keyword=">아웃도어/여행</a>
                      <a href="/regular/list?category=문화%2F공연%2F축제&subclass=모임+선택&city=지역+선택&district=세부지역+선택&keyword=">문화/공연/축제</a>
                      <a href="/regular/list?category=음악%2F악기&subclass=모임+선택&city=지역+선택&district=세부지역+선택&keyword=">음악/악기</a>
                      <a href="/regular/list?category=운동%2F스포츠&subclass=모임+선택&city=지역+선택&district=세부지역+선택&keyword=">운동/스포츠</a>
                      <a href="/regular/list?category=게임%2F오락&subclass=모임+선택&city=지역+선택&district=세부지역+선택&keyword=">게임/오락</a>
                      <a href="/regular/list?category=외국%2F언어&subclass=모임+선택&city=지역+선택&district=세부지역+선택&keyword=">외국어/언어</a>
                      <a href="/regular/list?category=기타&subclass=전체&city=지역+선택&district=세부지역+선택&keyword=">기타</a>
                    </ul>
                    <span class="togreg" >정기모임 지역</span>
                    <ul class="tunder">
                      <a href="/regular/list?category=관심분야+선택&subclass=모임+선택&city=서울특별시&district=세부지역+선택&keyword=">서울</a>
                      <a href="/regular/list?category=관심분야+선택&subclass=모임+선택&city=경기도&district=세부지역+선택&keyword=">경기</a>
                    </ul>
                </div>
                <div class="regtim gvut">
                  <span class="togreg tuncate">번개모임 카테고리 </span>
                  <ul class="tunder2">
                      <a href="/thunder/list?category=아웃도어%2F여행&subclass=모임+선택&city=지역+선택&district=세부지역+선택&keyword=">아웃도어/여행</a>
                      <a href="/thunder/list?category=문화%2F공연%2F축제&subclass=모임+선택&city=지역+선택&district=세부지역+선택&keyword=">문화/공연/축제</a>
                      <a href="/thunder/list?category=음악%2F악기&subclass=모임+선택&city=지역+선택&district=세부지역+선택&keyword=">음악/악기</a>
                      <a href="/thunder/list?category=운동%2F스포츠&subclass=모임+선택&city=지역+선택&district=세부지역+선택&keyword=">운동/스포츠</a>
                      <a href="/thunder/list?category=게임%2F오락&subclass=모임+선택&city=지역+선택&district=세부지역+선택&keyword=">게임/오락</a>
                      <a href="/thunder/list?category=외국%2F언어&subclass=모임+선택&city=지역+선택&district=세부지역+선택&keyword=">외국어/언어</a>
                      <a href="/thunder/list?category=기타&subclass=전체&city=지역+선택&district=세부지역+선택&keyword=">기타</a>
                  </ul>
                  <span class="togreg" style="margin:50px 0px 0px 30px;">번개모임 지역</span>
                    <ul class="tunder tunder2">
                      <a href="/thunder/list?category=관심분야+선택&subclass=모임+선택&city=서울특별시&district=세부지역+선택&keyword=">서울</a>
                      <a href="/thunder/list?category=관심분야+선택&subclass=모임+선택&city=경기도&district=세부지역+선택&keyword=">경기</a>
                    </ul>
                </div>
              </div><!--END <div class="dropreg">  -->
         </div><!-- END  <div id="myDropdown" class="dropdown-contentr">-->
         </div><!-- END <div class="submenudropdown"> -->
         <a class="submenu" href="/regular/list">정기모임</a>
         <a class="submenu" href="/thunder/list">번개모임</a>
         <a class="submenu" href="/hobbyTest/test">취미Test</a>
         <div class="dropdown">
            <a class="submenu" href="#">모임개설</a>
            <div class="dropdown-content ">
               <a href="/regular/add">정기모임</a>
               <a href="/thunder/add">번개모임</a>
            </div>
         </div>
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
   let msgNum = <sec:authentication property="principal.user.usrNum"/>;
   </sec:authorize>
   if(loginCheck == true){
      connectWS(msgNum);
      }
   
   $("#alram").on("click",function(){
      $("#alram").attr("src","/resources/img/bell.png")
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
    if (!event.target.matches('.dropbtnr')) {
      var dropdowns = document.getElementsByClassName("dropdown-contentr");
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
if(event.data == 'plus'){
   $("#alram").attr("src","/resources/img/bellplus.png");
   return;
}
if($(".socketAlert p").length == 4){
   $(".socketAlert p:last").remove();
}
$(".socketAlert").prepend("<p>"+event.data+"</p>");

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
         let headerKeyword = $.trim($("[name=headerKeyword]").val());
         $('[name=headerKeyword]').val(headerKeyword);

         console.log(headerKeyword.length);
         if (headerKeyword.length > 30) {
            alert("키워드가 너무 깁니다 (30자 이하)");
            return false;
         }
      }
   
      
</script>