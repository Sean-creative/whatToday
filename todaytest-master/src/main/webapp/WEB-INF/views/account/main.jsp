<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file = "../includes/header.jsp" %>

<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/account.css' />?after">
<nav id="nav">
<div class ="menu">
    <ul>
        <li>
            <form action="/account/main" method="get">
                <button class="btn1" type="submit"  style="color: yellow;">마이페이지</button>
            </form>
        </li>
            <li>
        <div class="dropdown">
            <button type="button" class="dropbtn">모임관리</button>
            <div class="dropdown-content">
            <ul>
                <li>
                <form action="/account/myclub/main" method="post">
            	<button type="submit">모임관리홈</button>
        		</form>
                </li>
                <li>                <form action="/account/myclub/main" method="post">
            	<button type="submit">만남개설</button>
        		</form></li>
                <li>                <form action="/account/myclub/main" method="post">
            	<button type="submit">회원관리</button>
        		</form></li>
                
                
            </ul>
            </div>
        </div>
        </li>
    <li>
        <form action="/account/auth_edit" method="get">
            <button type="submit">회원정보수정</button>
        </form>
    </li>
    <li>
        <form action="/account/password" method="get">
            <button type="submit">비밀번호수정</button>
        </form>
    </li>
    <li>
        <form action="/account/auth_leave" method="get">
            <button type="submit">회원탈퇴하기</button>
        </form>
        
        </li>
    </ul>

</div>
</nav>
<section id="wrap">
<div class ="info">
    <div class="pic">
    	<img src="${userVO.usrImg }" alt="My Image">
    <button>사진변경</button>
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
<c:forEach var="myClub" items="${myClub}">
   <li class="cb" value ="${myClub.cbNum}"><c:out value="[${myClub.cbType}] "/><c:out value="${myClub.cbName}"/></li><br>
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
	<div>
		<span onClick="closeLayer(this)" style="cursor:pointer;font-size:1.5em" title="닫기">X</span>
	</div>
	
</div>

</section>
<script type="text/javascript" src="/resources/js/club.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	
	

	
	function closeLayer( obj ) {
		$(obj).parent().parent().hide();
	}

	
	$(function(){

		/* 클릭 클릭시 클릭을 클릭한 위치 근처에 레이어가 나타난다. */
		$('.cb').click(function(e)
		{
			let index = $(".cb").index(this);
			let number = $(".cb").eq(index).val();
			
			console.log(index);
			
			console.log(number);
			
			var str = "";
			var type= "";
			clubService.getMyClublist({cbNum:number},function(list){
				if(list.cbType == '정기'|| list.cbType == '정기모임'){
					type = "regular"
				}else{
					type = "thunder";
				}
				str += '<form action="/'+type+'/info" method="get">';
				str += '<input type="hidden" name="cbNum" value="'+number+'">';
				str += '<button>수정하기->모임상세페이지로가서 수정</button>';
				str += '</form>';

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

				// 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치하자.
				if( divLeft < 0 ) divLeft = 0;
				if( divTop < 0 ) divTop = 0;
				
				
				$(".popupLayer").html(str);

				$('.popupLayer').css({
					"top": divTop,
					"left": divLeft,
					"position": "absolute"
				}).show();

			})
			
			

			
		});
	
});
});


</script>


    <%@include file = "../includes/footer.jsp" %>