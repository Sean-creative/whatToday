<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>    
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"> 
<link rel="stylesheet" href="<c:url value='/resources/css/index.css'/>">
   
   <!--TOP버튼-->
   <div class="top_btn">
      <a href="#"><i class="material-icons">keyboard_arrow_up</i></a>
   </div>
   
    <!-- main사진  -->
    <div id="mainheader">
        <ul class="back_visual">
              <li class="bv_1"></li>
              <li class="bv_2"></li>
              <li class="bv_3"></li>              
        </ul>
           <div class="in_visual">  <!-------------------------------비주얼-->
               <div id="mainnav"> <!------------------------------------- 메뉴 -->
                    <ul>
                        <li><a href="/regular/list">정기모임</a></li>
                        <li><a href="/thunder/list">번개모임</a></li>
                        <li><a href="/hobbyTest/test">추천테스트</a></li>
                        <li><a href="/regular/add">정기개설</a></li>
                        <li><a href="/thunder/add">번개개설</a></li>
                        <li><a href="">포인트충전소</a></li>
                        <li><a href="/cs/notice">고객센터</a></li>
                    </ul>
                    <div class="mainlogo"></div>

                </div>
                <h1>오늘뭐하지?</h1>
                <p class="subinfori">오늘뭐하지를 통해서<br> 즐겨보고 싶었던 취미를 만나보세요!</p>
               <!--  <div class="recomtest"><a href="">추천Test</a></div>
                <div class="regumak"><a href="">정기모임 </a></div> -->
                <div class="front_visual">
                    <ul>
                        <li class="fv_1"></li>
                        <li class="fv_2"></li>
                        <li class="fv_3"></li>
                    </ul>
                </div>
        </div>
    </div><!-- END  mainheader -->

<!-- 스크롤시 내려오는 메뉴 -->
<div id="header">
   <div id="head">
      <div class="menu1">
         <a href="/index/main">
            <img src="/resources/img/logo.png" alt="logo">
         </a>
         <form action="/index/searchlist" method="get" onsubmit="return inputCheckMain()">
            <input type="text" name="headerKeyword" placeholder="관심분야를 입력해주세요:)">
         </form>
      </div>
         <sec:authorize access="isAnonymous()">
            <div class="menu2">
               <li><a href="/login/login">로그인</a></li>
               <li><a href="/cs/notice">고객센터</a></li>
            </div>
         </sec:authorize>
          <!-- 로그인되면 보여지는 페이지 -->
            <sec:authorize access="isAuthenticated()">
               <div class="menu2">
                  <li><a href="/mypage/main" id="user"><sec:authentication property="principal.user.usrName" />님</a></li>    
                  <li>
                  <div class="tooltip">
                  <img id="alram" src="/resources/img/bell.png" alt="bell" style="width: 20px; height: 20px; margin: 10px 5px 0px 0px; margin-top:-10px;">
                  <div class="tooltiptext">
                  <div id="socketAlert" class="alert alert-success" role="alert"></div>
                     </div>
                     </div>
                     </li>
                  <li><a href="/login/logout">로그아웃</a></li>
                  <li><a href="/cs/notice">고객센터</a></li>
                  
               </div>
            </sec:authorize>
      
      </div>
      <!--  -->
      <div id="nav">
            <!-- 여기 -->
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
              </div>
            </div>
          </div>
            <a class="submenu" href="/regular/list">정기모임</a>
            <a class="submenu" href="/thunder/list">번개모임</a>
            <a class="submenu" href="/hobbyTest/test">추천테스트</a>
            <div class="dropdown">
            <a class="submenu" href="#">모임개설</a>
            <div class="dropdown-content ">
               <a href="/regular/add">정기모임</a>
               <a href="/thunder/add">번개모임</a>
            </div>
         </div>
        </div>
   </div>
   <!--내려오면 보이는 화면 끝  -->
    
<!-- =================정기모임 ==================== -->
<div class="regular">
	<div>
	   <span class="half">정기모임</span><br>
	   <p class="halfunder">즐거운 정기모임을 만나보세요!</p>
	</div>
	<div class="masmam"><a href="">모임 더 보 기 ></a></div>
</div>
<div id="searchresult">
   <c:forEach items="${main}" var="club" varStatus="status" begin="0" end="11">
      <div>
         <a href='/regular/info?cbNum=<c:out value="${club.cbNum}" />'>
            <img src='<c:out value="${club.cbFile}" />' alt="">
            <p class="topinfo">#${club.cbCategory} #${club.cbSubcat} 
            <br> #${club.cbDistrict} #${club.cbName}</p>
            <p class="nombre">${club.cbIntro}</p>
            <p class="count">⍤ ${club.cbCurMbNum}명이 모였습니다.</p>
         </a>
      </div>
   </c:forEach>
</div>

     <!-- =================베너======================== -->
   <div class="slideshow-container">

        <div class="mySlides fade">
          <a href="/hobbyTest/test">
             <img src="/resources/img/banner1.jpg">
          </a>   
        </div>
        
        <div class="mySlides fade">
           <a href="/regular/list">
                <img src="/resources/img/banner2.jpg">
           </a>
        </div>
        
       <!--  <div class="mySlides fade">
          <img src="img/paint2.jpg">
        </div> -->
        
        <div class="dotted">
          <span class="dot"></span> 
          <span class="dot"></span> 
          <!-- <span class="dot"></span>  -->
        </div>
    </div>

<!-- 번개모임 -->
<div class="regular thunder">
   <div>
	   <span class="half">번개모임</span><br>
	   <p class="halfunder">즐거운 번개모임을 만나보세요!</p>
	</div>
	<div class="masmam"><a href="">모임 더 보 기 ></a></div>
</div>
<div id="searchresult">
   <c:forEach items="${main2}" var="club" varStatus="status" begin="0" end="11">
      <div>
         <a href='/thunder/info?cbNum=<c:out value="${club.cbNum}" />'>
            <img src='<c:out value="${club.cbFile}" />' alt="">
            
            <p class="topinfo">#${club.cbCategory} #${club.cbSubcat} #${club.cbDistrict}</p>
            <p class="cbName">${club.cbName}</p>
			
			<c:set var="today" value="<%=new java.util.Date()%>" />
			<fmt:formatDate var="today" value="${today}" pattern="yyyyMMdd"/>
			<fmt:parseDate var="meetDay" value='${club.cbDate}' pattern="yyyy-MM-dd'T'HH:mm" />
			<fmt:formatDate var="meetDay" value="${meetDay}" pattern="yyyyMMdd"/>
			
			<c:set var="cbMbNum" value = "${club.cbMbNum}" />
			<c:set var="cbCurMbNum" value = "${club.cbCurMbNum}" />
			
			<p class="count">⍣ ${club.cbView}명이 보고있습니다.</p>
			
			<span class="meetDday">D-<c:out value="${meetDay-today}"/></span>
       		<span class="meetDday"><c:out value="${cbMbNum-cbCurMbNum}" />명</span>
       		<br>
			
			<!--  
            <fmt:parseDate var="dateString" value='${club.cbDate}' pattern="yyyy-MM-dd'T'HH:mm" />
            <p class="limitmem"><fmt:formatDate value="${dateString}" pattern="M월 d일  E'요일' a h시  m분" /></p>
			-->
			
         </a>
      </div>
   </c:forEach>
</div>


<div class="regular todayHot">
	<div>
	   <span class="half">TODAY</span><br>
	   <p class="halfunder">오늘의 추천 취미는?</p>
	</div>
</div>
<div id ="today">
	<div class="todayImg">
		<a href="http://localhost:8088/regular/list?category=문화/공연/축제&subclass=뮤지컬/오페라"><img src="/resources/img/subclass/musical.jpg" alt="musical">
			<div class="middle"><div class="Imgtext">#뮤지컬/오페라</div></div>
		</a>
	</div>
	<div class="todayImg">
		<a href="http://localhost:8088/regular/list?category=외국/언어&subclass=프랑스어"><img src="/resources/img/subclass/french.jpg" alt="french">
			<div class="middle"><div class="Imgtext">#프랑스어</div></div>
		</a>
	</div>
	<div class="todayImg">
		<a href="http://localhost:8088/regular/list?category=게임/오락&subclass=보드게임"><img src="/resources/img/subclass/boardGame.jpg" alt="boardGame">
			<div class="middle"><div class="Imgtext">#보드게임</div></div>
		</a>
	</div>
</div>

<script src="http://code.jquery.com/jquery-3.3.1.js"></script>
<script>
/*====================이미지================*/
$(document).ready(function(){

    var oldidx=0;
    var idx=0;
       
       function changeImg(idx){
           
           if(oldidx!=idx){
               $(".back_visual li").eq(idx).stop(true,true).fadeIn(300); 
               $(".back_visual li").eq(oldidx).stop(true,true).fadeOut(300);
            $(".front_visual li").eq(idx).stop(true,true).fadeIn(300); 
            $(".front_visual li").eq(oldidx).stop(true,true).fadeOut(300); 
           }
           oldidx=idx; 
       }
    function changeAuto(){
           idx++;
           if(idx>2){ 
               idx=0;
           }
           changeImg(idx);
       }
       timer=setInterval(changeAuto,3000);   
        
/*=====================웹소켓================  */
       var socket = null;  //전역 변수로 선언

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
/*================중간베너===================  */
   var slideIndex = 0;
        showSlides();
           
       function showSlides() {
        var i;
        var slides = document.getElementsByClassName("mySlides");
        var dots = document.getElementsByClassName("dot");
        for (i = 0; i < slides.length; i++) {
         slides[i].style.display = "none";  
       }
        slideIndex++;
       if (slideIndex > slides.length) {slideIndex = 1}    
      for (i = 0; i < dots.length; i++) {
      dots[i].className = dots[i].className.replace(" active", "");
      }
     slides[slideIndex-1].style.display = "block";  
     dots[slideIndex-1].className += " active";
     setTimeout(showSlides, 3000); // Change image every 2 seconds
}



/*================스크롤시 내려오는 메뉴 ===============  */
window.onscroll = function() {scrollFunction()};

function scrollFunction() {
   if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
       document.getElementById("header").style.top = "0";
   } else {
       document.getElementById("header").style.top = "-121px";
   }
}


   
/*===========햄버거 메뉴 =================   */ 

   
     function myFunction() {
        document.getElementById("myDropdown").classList.toggle("show");
      }

      // Close the dropdown if the user clicks outside of it
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

function connectWS(msgNum){

var ws = new WebSocket("ws://localhost:8088/echo2/websocket");

socket = ws;
let Num = msgNum;
ws.onopen = function(message){
  
   ws.send(msgNum+","+"접속");
};

ws.onmessage = function(event){
	console.log(event.data);
	if(event.data == 'plus'){
	   $("#alram").attr("src","/resources/img/bellplus.png");
	}
	if($("#socketAlert p").length == 4){
	   $("#socketAlert p:last").remove();
	}
	$("#socketAlert").prepend("<p>"+event.data+"</p>");

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


      };

      
</script>
<footer>
        <div class="canizo">
          <div class="ftlef">
            <a href="#">서비스 이용약관</a>
            <a href="#">개인정보취급방침</a>
            <a href="/cs/notice">고객센터</a>
          </div>
          <div class="ftrig">
            <li class="ftnaver">
              <a href=""></a>
            </li>  
            <li class="ftkakao"> 
              <a href=""></a>
            </li>
          </div>
        </div>
        <div class="canizo2">
          <p class="quetday">오늘뭐하지?</p>
          <div class="fotinf">
            <p>서울특별시 종로구 종로2가 9, 11층</p>
            <p>김선우,김지영,국민성,조다혜,이수진</p>
            <p>https://github.com/Sean-creative/whatToday</p>
            <p>whattodayhobby@gmail.com</p>
            <p>02-722-1481 (문의시간:10:00~17:00/점심시간 : 13:00~14:00)</p>
          </div>
          <div class="fotinf2">
            <p>© WhatToday Inc. 2020 All Rights Reserved.</p>
          </div>
        </div>
    </footer>
    
</body>
</html>