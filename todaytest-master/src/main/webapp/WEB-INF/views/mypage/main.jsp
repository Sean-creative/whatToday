<%@page import="com.mchange.v2.cfg.PropertiesConfigSource.Parse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file = "../includes/header.jsp" %>
<% int num = 2; 
%>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/mypage.css' />?after">
<nav id="nav">
<div class ="menu">
    <ul>
        <li>
            <form action="/mypage/main" method="get">
                <button class="btn1" type="submit"  style="color: yellow;">마이페이지</button>
            </form>
        </li>
            <li>
        <div class="dropdown">
            <button type="button" class="dropbtn">모임관리</button>
            <div class="dropdown-content">
            <ul>
                <li>
                <form action="/mypage/myclub/main" method="get">
            	<button type="submit">모임관리홈</button>
        		</form>
                </li>
                <li>                <form action="/mypage/myclub/main" method="post">
            	<button type="submit">만남개설</button>
        		</form></li>
                <li>                <form action="/mypage/myclub/main" method="post">
            	<button type="submit">회원관리</button>
        		</form></li>
                
                
            </ul>
            </div>
        </div>
        </li>
    <li>
        <form action="/mypage/auth_edit" method="get">
            <button type="submit">회원정보수정</button>
        </form>
    </li>
    <li>
        <form action="/mypage/password" method="get">
            <button type="submit">비밀번호수정</button>
        </form>
    </li>
    <li>
        <form action="/mypage/auth_leave" method="get">
            <button type="submit">회원탈퇴하기</button>
        </form>
        
        </li>
    </ul>

</div>
</nav>
<section id="wrap">
<div class ="info">
    <div class="pic">
    	<img style='width:100px; height:100px;' src="\resources\img\upload\<c:out value="${userVO.usrImgPath }"/>\<c:out value="${userVO.usrImg }"/>"
		alt="로딩중"/>
    </div>
	<div class="userInfo">
		<p>ID : ${userVO.usrId } </p>
		<p>NAME : ${userVO.usrName }</p>	
		<p>PHONE : ${userVO.usrPhone }</p>	
		<p>BIRTH : ${userVO.usrBirth }</p>
		<p>GENDER : ${userVO.usrGender }</p>
	</div>
</div>
<div class ="info">
<div class ="clubInfoSmall">
<p>가입한 모임</p><br>
<ul style="list-style-type: none;">

<!-- 보여줄갯수 변수로 설정 -->

<c:forEach var="clubVO" items="${clubVO}" varStatus="status" begin ="0" end = "<%=num%>">
    <li class="cb" value ="${clubVO.cbNum}"><c:out value="[${clubVO.cbType}] "/><c:out value="${clubVO.cbName}"/>
    <input type="hidden" class="cb2" value ="${clubVO.cbType}">
    </li><br>
</c:forEach>

<c:forEach var="clubVO" items="${clubVO}" varStatus="status" begin = "<%=num+1%>">
        <c:if test="${status.first}"><p class="moreList">더보기</p></c:if>
<li class="cb hideList" style ="display: none" value ="${clubVO.cbNum}"><c:out value="[${clubVO.cbType}] "/><c:out value="${clubVO.cbName}"/></li><br>
<c:if test="${status.last}"><p class="closeList" style ="display: none">감추기</p></c:if>
</c:forEach>






</ul>
</div>
<div class ="clubInfoSmall">
<p>가입 신청 대기중인 모임</p><br>
<c:forEach var="waitClub" items="${waitClub}">
   <c:out value="[${waitClub.cbType}] "/><c:out value="${waitClub.cbName}"/><br>
</c:forEach>
</div>
<div class ="clubInfoSmall">
<p>이전 가입했던 모임</p><br>
<c:forEach var="prevClub" items="${prevClub}">
<c:out value="[${prevClub.cbType}]" /><c:out value="${prevClub.cbName}"/><br>
</c:forEach>
</div>
</div>
<div class="popupLayer">
<div class="popupLayer2">

</div>
<span class="closeWin" style="cursor:pointer;font-size:2em;" title="닫기">X</span>

	
</div>

</section>
<script type="text/javascript" src="/resources/js/club.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	if("${msg}" != ""){
		alert("${msg}");
	}

	$(".moreList").click(function(){
		$(".hideList").show();
		$(".moreList").hide();
		$(".closeList").show();
	})
	
	$(".closeList").click(function(){
		$(".hideList").hide();
		$(".moreList").show();
		$(".closeList").hide();
	})
	
	$(function(){

		$(".closeWin").click(function(e)
		{
			$(".popupLayer").hide()
		});

		

		/* 클릭 클릭시 클릭을 클릭한 위치 근처에 레이어가 나타난다. */
		/*ajax 안쓰고 하는걸로 바꾸기*/

		$('.cb').click(function(e)
		{ 
			let index = $(".cb").index(this);
			let number = $(".cb").eq(index).val();

			let type = $(".cb").eq(index).children(".cb2").val();

			console.log(index);
			
			console.log(number);
			
			console.log(type);
			
			var str = "";
			/*var type= "";
			 clubService.getJoinClub({cbNum:number},function(club){
				if(club.cbType == '정기'|| club.cbType == '정기모임'){
					type = "regular"
				}else{
					type = "thunder";
				} 
				console.log(club.cbType);*/
				str += '<form name="joinClub" method="get">';
				str += '<input type="hidden" name="cbNum" value="'+number+'">';
				str += '<button name="details">상세보기</button>';
				str += '</form>';
				str += '<button>탈퇴하기-아직구현X</button>'

				let sWidth = window.innerWidth;
				let sHeight = window.innerHeight;

				let oWidth = $('.popupLayer').width();
				let oHeight = $('.popupLayer').height();

				// 레이어가 나타날 위치를 셋팅한다.
				let divLeft = e.clientX + 10;
				let divTop = e.clientY + 5;

				// 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치한다.
				if( divLeft + oWidth > sWidth ) divLeft -= oWidth;
				if( divTop + oHeight > sHeight ) divTop -= oHeight;

				// 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치.
				if( divLeft < 0 ) divLeft = 0;
				if( divTop < 0 ) divTop = 0;
				
				
				$(".popupLayer2").html(str);

				$('.popupLayer').css({
					"top": divTop,
					"left": divLeft,
					"position": "absolute"
				}).show();

			/* }) */
			
				$("button[name=details]").click(function(){
		
					let form = $("form[name=joinClub]");
				

					if(type == "번개모임"){
						console.log("번개요");
						url = "/thunder/info";
					}else{
						console.log("정기요");
						url = "/regular/info";
					}
					form.attr("action",url);
				});
			
			

			
		});
		
	
		
	
});
	

});


</script>


    <%@include file = "../includes/footer.jsp" %>