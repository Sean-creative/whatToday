<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c"%>    

<link rel="stylesheet" href="<c:url value='/resources/css/index.css'/>">

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
                        <li><a href="/hobbyTest/test">추천TEST</a></li>
                        <li><a href="/regular/add">정기개설</a></li>
                        <li><a href="/thunder/add">번개개설</a></li>
                        <li><a href="">포인트충전소</a></li>
                        <li><a href="/cs/notice">고객센터</a></li>
                    </ul>
                    <div class="mainlogo"></div>

                </div>
                <h1>오늘뭐하지?<br>당신의 즐거운 취미를 찾아드립니다.</h1>
                <div class="front_visual">
                    <ul>
                        <li class="fv_1"></li>
                        <li class="fv_2"></li>
                        <li class="fv_3"></li>
                    </ul>
                </div>
        </div>
    </div>

    <!-- 스크롤시 내려오는 메뉴 -->
    <div id="header">
		<div id="head">
			<div class="menu1">
				<a href="/index/main"> <img src="/resources/img/logo.png"
					alt="logo"></a>
				<form action="/index/searchlist" method="get"
					onsubmit="return inputCheckMain()">
					<input type="text" name="keyword" placeholder="관심분야를 입력해주세요:)" >
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
		<div id="nav">
			<div id="myNav" class="overlay">
				<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
				<div class="overlay-content">
					<div class="tab">
						<button class="tablinks" onclick="openMix(event, 'Regular')"
							id="defaultOpen">정기모임</button>
						<button class="tablinks" onclick="openMix(event, 'Thunder')">번개모임</button>
					</div>
					<div id="Regular" class="tabcontent">
						<a href="#hello">정기모임1</a> <a href="">정기모임2</a> <a href="">정기모임3</a>
					</div>

					<div id="Thunder" class="tabcontent">
						<a href="">번개모임1</a> <a href="">번개모임2</a> <a href="">번개모임3</a>
	
					</div>
				</div>
			</div>
			<span class="menubtn" style="font-size: 30px; cursor: pointer"
				onclick="openNav()">&#9776;</span> <a class="submenu"
				href="/regular/list">정기모임</a> <a class="submenu"
				href="/thunder/list">번개모임</a> <a class="submenu" href="#">베스트</a> <a
				class="submenu" href="#">취미Test</a>
			<div class="dropdown">
				<a class="submenu" href="#">모임개설</a>
				<div class="dropdown-content ">
					<a href="/regular/add">정기모임</a> <a href="/thunder/add">번개모임</a>
				</div>
			</div>
		</div>
	</div>
	<!--내려오면 보이는 화면 끝  -->
    
    <!-- =================정기모임 ==================== -->
    <div class="regular">
        <span class="half">정기모임</span><br>
        <p class="halfunder">즐거운 정기모임을 만나보세요!</p>
    </div>
    <div id="searchresult">
    	<c:forEach items="${main}" var="club" varStatus="status" begin="0" end="11">
	        <div>
	            <a href='/regular/info?cbNum=<c:out value="${club.cbNum}" />'>
	                <img src="/resources/img/paint.jpg" alt="">
	                <p class="location"><c:out value="${club.cbCity}" /></p><!-- 위치 -->
	                <p class="nombre"><c:out value="${club.cbName}" /> </p> <!--이름  -->
	                <hr style="color:#eee;">
	                <p class="limitmem"><c:out value="${club.cbCurMbNum}" /> / <c:out value="${club.cbMbNum}" /> 명 </p>
	            </a>    
	        </div>
	     </c:forEach>    
     </div>   
     
     <!-- =================베너======================== -->
   <div class="slideshow-container">

        <div class="mySlides fade" style="background-color: #ab1111;">
          <img src="img/basketball.jpg">
        </div>
        
        <div class="mySlides fade" style="background-color: bisque;">
          <img src="img/mount.jpg">
        </div>
        
        <div class="mySlides fade" style="background-color: cornflowerblue;">
          <img src="img/paint2.jpg">
        </div>
        
        <div class="dotted">
          <span class="dot"></span> 
          <span class="dot"></span> 
          <span class="dot"></span> 
        </div>
    </div>
     
    <!-- 번개모임 -->
    <div class="regular thunder">
        <span class="half">번개모임</span><br>
        <p class="halfunder">즐거운 번개모임을 만나보세요!</p>
    </div>
    <div id="searchresult">
    	<c:forEach items="${main2}" var="club" varStatus="status" begin="0" end="11">
        <div>
            <a href='/thunder/info?cbNum=<c:out value="${club.cbNum}" />'>
                <img src="/resources/img/mount.jpg" alt="">
                <p class="location"><c:out value="${club.cbCity}" /></p>
                <p class="nombre"><c:out value="${club.cbName}" /></p>
                <hr style="color:#eee;">
                <p class="limitmem">11월 23일 월요일 오후 2시 31분</p>
                <p class="limitmem"><c:out value="${club.cbCurMbNum}" /> / <c:out value="${club.cbMbNum}" /> 명</p>
            </a>    
        </div>
        </c:forEach>
      </div>  
    

    
   <%--  <div id="sub">
        <p class="hhh">지금 뭐하지?</p>
        <ul>
	          <c:forEach items="${main2}" var="club" varStatus="status" begin="1" end="11">
							<li>
							    <a href='/thunder/info?cbNum=<c:out value="${club.cbNum}" />'>
								<p>위치 : <c:out value="${club.cbCity}" /></p>
								<p>현재정원 : <c:out value="${club.cbCurMbNum}" /></p>
								<p>모임이름 : <c:out value="${club.cbName}" /></p>
								<p>유형  : <c:out value="${club.cbType}" /></p>
								</a>
							</li>	
				</c:forEach>
        </ul>
    </div>  --%>



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
          setTimeout(showSlides, 2000); // Change image every 2 seconds
        }
</script>

<%@ include file="../includes/footer.jsp"%> 
    
</body>
</html>
    