<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file = "../includes/header.jsp" %>
<link id="myCss" rel="stylesheet" type="text/css" href="<c:url value='/resources/css/mypage.css' />?after">
<nav id="navMenu">
<div class ="mypageMenu">
    <ul>
        <li>
            <form action="/mypage/main" method="get">
                <button class="btn1" type="submit">마이페이지</button>
            </form>
        </li>
            <li>
        <div class="dropdown2">
            <button type="button" class="dropbtn">모임관리</button>
            <div class="dropdown-content2">
            <ul>
                <li>
                <form action="/mypage/myclub/main" method="get">
            	<button type="submit">모임관리홈</button>
        		</form>
                </li>
                <li>                <form action="/mypage/myclub/main" method="post">
            	<button type="submit">만남개설</button>
        		</form></li>
                <li>                <form action="/mypage/myclub/userManage" method="get">
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
            <button type="submit" style="color: yellow;">비밀번호수정</button>
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
<section id="wrapInfo">
<div style="margin: 0 auto;">
    <h1 style="text-align: center;">비밀번호 변경</h1><br>
    <h5 style="text-align: left;">개인정보보호를 위해 최소 3개월 이내에는 정기적으로 비밀번호를 변경해주시는 게 좋습니다.</h5><br>
    <h5 style="text-align: left;">비밀번호는 쉬운번호나 타 사이트와 같은 경우 도용되기 쉽습니다.</h5><br>
    <h5 style="text-align: left;">주민번호, 전화번호, 생일 등 개인정보와 연관된 문자나 숫자는 보안상 위험이 높으므로 사용을 자제해 주세요.</h5><br>
    <br>
</div>
<div class="pwdInput">
<div style="width: 430px;">
<span class="pwWord">현재 비밀번호 입력</span>
<input type="password" class="inputPwd" name="currentPassword">
<span class="pwWord">새로운 비밀번호 입력</span><input type="password" class="inputPwd" name="newPassword">
<span class="pwWord">새로운 비밀번호 확인</span><input type="password" class="inputPwd" name="newPassword">
<form name="register" action="/mypage/passwordAction" onsubmit="return check();" method="post">
<input type="hidden" name="currentPassword" value="">
<input type="hidden" name="newPassword" value="">
<button class="modifyBtn2">변경완료</button>
</form>
</div>

</div>

</section>
<script type="text/javascript">
if("${msg}" != ""){
	alert("${msg}");
}



let currentPassword = document.getElementsByName("currentPassword");
let newPassword = document.getElementsByName("newPassword");
    /* 유효성검사, 빈칸검사, 새 비밀번호 맞는지 확인검사 */
let check = function (){
	if(blankCheck() &&
			passwordEqualCheck() && validCheck()){
        currentPassword[1].setAttribute("value", currentPassword[0].value);
        newPassword[2].setAttribute("value", newPassword[0].value);
		return true;
	}
	
	return false;
}
    
let blankCheck = function (){

    if(currentPassword[0].value.length == 0 ||
    		newPassword[0].value.length == 0 ||
    		newPassword[1].value.length == 0){
    	alert("빈칸을 입력해주세요")
        return false;
    }
    return true;
}
let passwordEqualCheck = function (){
	if(currentPassword[0].value == newPassword[0].value){
		alert("현재 비밀번호와 새로운 비밀번호를 다르게 입력해주세요");
		return false
	}
	if(newPassword[0].value == newPassword[1].value){
		return true;
	}
	alert("새비밀번호와 새비밀번호확인이 맞지 않음");
	return false
}
let validCheck = function () {
	
	let cpw = document.register.currentPassword;
	let npw = document.getElementsByName("newPassword")[0];
	let npwRe = document.getElementsByName("newPassword")[1];

	
	const pwPattern = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W))(?=.*[0-9]).{8,16}$/;

    if(pwPattern.test(npw.value) == false || pwPattern.test(npwRe.value) == false){
    	alert("새로운 비밀번호는 숫자+영어+특문 포함 8자 이상");
        return false;
    }

    return true;

  
    
}
</script>

    <%@include file = "../includes/footer.jsp" %>