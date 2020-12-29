<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file = "../includes/header.jsp" %>
<link id="myCss" rel="stylesheet" type="text/css" href="<c:url value='/resources/css/mypage.css' />?after">
<div id="totalMenu">
	<nav id="navMenu">
		<div class="mypageMenu">
			<div class="uInfo">
				<img src="\resources\img\upload\<c:out value="${userVO.usrImgPath }"/>\<c:out value="${userVO.usrImg }"/>"><br>
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

					<form action="/mypage/myclub/main" method="post">
						<button type="submit">만남개설</button>
					</form>

					<form action="/mypage/myclub/userManage" method="get">
						<button type="submit">모임회원관리</button>
					</form>

				<form action="/mypage/auth_edit" method="get">
					<button type="submit">회원정보수정</button>
				</form>
				<form action="/mypage/password" method="get">
					<button type="submit">비밀번호수정</button>
				</form>
				<form action="/mypage/auth_leave" method="get">
					<button type="submit"  style="color: yellow;">회원탈퇴하기</button>
				</form>
			</div>
		</div>
	</nav>
	
<section id="wrapInfo2">
<div class = "pwdInput">
        <h1 style="text-align: center;">비밀번호재입력</h1><br>
        <h3>본인확인을 위해 <span class="word">로그인 비밀번호</span>를 한 번 더 입력해주세요.</h3>
        <br><br>
        <form id="dropForm"action="/mypage/leaveAction"  method="get">
        <input placeholder="비밀번호" type="password" class="inputPwd" name="password"><br>
        <button type="button" id="myBtn" class ="modifyBtn2">확인</button><!-- 클릭시 blank 체크한다 -->
<!-- 		<div id="myModal" class="modal">
		  <div class="modal-content">
		    <h1>탈퇴하시겠습니까?</h1>
		    <button type ="submit" class="check">확인</button>
		    <button type="button" class="close">취소</button>
		  </div>
		</div> -->
        </form>
    </div>
</section>
</div>
<!-- The Modal -->


<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

if("${msg}" != ""){
	swal("${msg}", "", "error");
}
/* let modal = document.getElementById("myModal"); */

//Get the button that opens the modal
let btn = document.getElementById("myBtn");
let dropForm = document.getElementById("dropForm");
//Get the <span> element that closes the modal
/* let close = document.getElementsByClassName("close")[0]; */


//When the user clicks the button, open the modal 
btn.onclick = function () {
	let password = document.getElementsByName("password");
	 if(password[0].value.length == 0){
		 swal("비밀번호를 입력해주세요.", "", "warning");
		 return;
	    }else{
	    	swal({
	    		  title: "정말 탈퇴하시겠어요?",
	    		  text: "정말 정말 정말로?",
	    		  icon: "warning",
	    		  buttons: true,
	    		  dangerMode: true,
	    		})
	    		.then((willDelete) => {
	    		  if (willDelete) {
	    			  dropForm.submit();
	    		    } else {
	    		    swal("감사합니다!");
	    		  }
	    		});
	    }
	/* modal.style.display = "block"; */
}

//When the user clicks on <span> (x), close the modal
/* close.onclick = function() {
modal.style.display = "none";
} */

//When the user clicks anywhere outside of the modal, close it
/* window.onclick = function(event) {
if (event.target == modal) {
 modal.style.display = "none";
}
} */

</script>

    <%@include file = "../includes/footer.jsp" %>