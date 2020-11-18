<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file = "../includes/header.jsp" %>



<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/account.css' />?after">
<nav id="nav">
<div class ="menu">
    <ul>
        <li>
            <form action="/account/main" method="post">
                <button class="btn1" type="submit"  style="color: yellow;">마이페이지</button>
                <input type="hidden" name = "usrId" value=${userVO.usrId }>
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
                <li>                <form action="/account/myclub/main" method="post">
            	<button type="submit">모임수정</button>
        		</form></li>
                <li>                <form action="/account/myclub/main" method="post">
            	<button type="submit">모임폐쇄</button>
        		</form></li>
            </ul>
            </div>
        </div>
        </li>
    <li>
        <form action="/account/auth_edit" method="post">
            <button type="submit">회원정보수정</button>
        </form>
    </li>
    <li>
        <form action="/account/password" method="post" >
            <button type="submit">비밀번호수정</button>
        </form>
    </li>
    <li>
        <form action="/account/auth_leave" method="post">
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
        <form action="/account/leaveAction"  method="post">
        <input type="password" class="inputPwd" name="password"><br>
        <button type="button" id="myBtn">확인</button><!-- 클릭시 blank 체크한다 -->
		<div id="myModal" class="modal">
		  <div class="modal-content">
		    <h1>탈퇴하시겠습니까?</h1>
		    <button type ="submit" class="check">확인</button>
		    <button type="button" class="close">취소</button>
		  </div>
		</div>
        </form>
    </div>
</div>
</section>
<!-- The Modal -->



<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
var modal = document.getElementById("myModal");

//Get the button that opens the modal
var btn = document.getElementById("myBtn");

//Get the <span> element that closes the modal
var close = document.getElementsByClassName("close")[0];


//When the user clicks the button, open the modal 
btn.onclick = function () {
	var password = document.getElementsByName("password");
	 if(password[0].value.length == 0){
		 alert("비밀번호를 입력해주세요");
		 return;
	    }
	modal.style.display = "block";
}

//When the user clicks on <span> (x), close the modal
close.onclick = function() {
modal.style.display = "none";
}

//When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
if (event.target == modal) {
 modal.style.display = "none";
}
}
</script>

    <%@include file = "../includes/footer.jsp" %>