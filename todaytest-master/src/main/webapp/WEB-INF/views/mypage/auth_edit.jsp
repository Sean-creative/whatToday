<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file = "../includes/header.jsp" %>
<link id="myCss" rel="stylesheet" type="text/css" href="<c:url value='/resources/css/mypage.css' />?after">
<div id="totalMenu">
	<nav id="navMenu">
		<div class="mypageMenu">
			<div class="uInfo">
				<img
					src="\resources\img\upload\<c:out value="${userVO.usrImgPath }"/>\<c:out value="${userVO.usrImg }"/>"><br>
				<h5>${userVO.usrName }</h5>
				<br>
				<h5>${userVO.usrId }</h5>
				<br>
				<h5>포인트 ${userVO.usrPoint }점</h5>
			</div>


			<div class="info">
				<h1>메뉴</h1>
				<form action="/mypage/main" method="get">
					<button type="submit">마이페이지</button>
				</form>
				
					<form action="/mypage/myclub/main" method="get">
						<button type="submit">모임관리</button>
					</form>


					<form action="/mypage/myclub/userManage" method="get">
						<button type="submit">모임회원관리</button>
					</form>
				<form action="/mypage/auth_edit" method="get">
					<button type="submit" style="color: yellow;">회원정보수정</button>
				</form>
				<form action="/mypage/password" method="get">
					<button type="submit">비밀번호수정</button>
				</form>
				<form action="/mypage/auth_leave" method="get">
					<button type="submit">회원탈퇴하기</button>
				</form>
			</div>
		</div>
	</nav>
	
<section id="wrapInfo2">
<div class = "pwdInput">

        <h1 style="text-align: center;">비밀번호재입력</h1><br>
        <h3>본인확인을 위해 <span class="word">로그인 비밀번호</span>를 한 번 더 입력해주세요.</h3>
        <br><br>
        <form action="/mypage/authAction" onsubmit="return blankCheck();" method="post">
        <input type="password" class="inputPwd" name="password" placeholder="비밀번호"><br>
        <button type="submit" class="modifyBtn2">확인</button>
        </form>

</div>

</section>
</div>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
console.log("${msg}");
if("${msg}" != ""){
	swal("${msg}", "", "error");
}

let blankCheck = function(){
    let password = document.getElementsByName("password");
    if(password[0].value.length == 0){
    	swal("비밀번호를 입력해주세요.", "", "warning");
        return false;
    }
    return true;
}


</script>



    <%@include file = "../includes/footer.jsp" %>