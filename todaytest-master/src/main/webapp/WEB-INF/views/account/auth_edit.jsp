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
                <button class="btn1" type="submit" >마이페이지</button>

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
            <button type="submit" style="color: yellow">회원정보수정</button>
        </form>
    </li>
    <li>
        <form action="/account/password" method="get" >
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
<div class = "pwdInput">
    <div>
        <h1 style="text-align: center;">비밀번호재입력</h1><br>
        <p style="text-align: center;">본인확인을 위해 <span class="word">로그인 비밀번호</span>를 한 번 더 입력해주세요.</p>
        <br><br>
        <form action="/account/authAction" onsubmit="return blankCheck();" method="post">
        <input type="password" class="inputPwd" name="password"><br>
        <button type="submit">확인</button>
        </form>
    </div>
</div>
</section>

<script type="text/javascript">


function blankCheck(){
    var password = document.getElementsByName("password");
    if(password[0].value.length == 0){
    	alert("비밀번호를 입력해주세요.") 
        return false;
    }
    return true;
}
</script>



    <%@include file = "../includes/footer.jsp" %>