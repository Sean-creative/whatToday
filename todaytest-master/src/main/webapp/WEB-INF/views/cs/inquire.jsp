<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>

<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"> 
<link rel="stylesheet" href="<c:url value='../resources/css/inquire.css'/>">

 <div id="wrap">

	
	<div class="s-visual">
		<div class="s-visual-in">
			<!-- <h2>문의사항</h2>
			<h4>INQUIRE</h4> -->
		</div>
	</div>

	<!--TOP버튼-->
	<div class="top_btn">
	   <a href="#"><i class="material-icons">keyboard_arrow_up</i></a>
	</div>

    <div class="notimenu">
        <div class="notisubmenu">
            <a href="/cs/notice">공지사항 </a>
            <a href="/cs/faq">자주묻는질문 </a>
            <a href="/cs/inquire">문의사항 </a>
        </div>
    </div>

	<section id="container">
		<div class="section_in">
			<p class="load">HOME &gt; 고객센터 &gt; 1:1문의사항</p>
			<h2>1대1 문의하기</h2>
			<p>INQUIRE</p>

			<!-- 탭메뉴 -->

			<!-- 탭메뉴클릭시 -->
			<form role="form" action="/cs/mailRequest" method="post" name="inquire" onsubmit="return inputCheck()">
				<h6 class="form-stxt">*필수 입력사항&nbsp;&nbsp;</h6>
				<hr>
				<fieldset class="formContent">
					<div>
						<input type='hidden' name='usrNum' value="${usrNum}">
						<label for="name">이름*</label>
						<input type="text" name='qsName' class="name" value="${usrName}" readonly style="width:100px; height:25px;">
					</div>
					
					<div>
						<label for="hp">연락처*</label>
						<input type="text" name='qsPhone' class="phone" placeholder="- 빼고 입력해주세요" id="phone" style="width:150px; height:25px;">
					</div>
					<div>
						<label for="email">이메일*</label>
                        <input type="email" name='qsEmail' id="email" style="width:200px; height:25px;">
                        <span class="required">   *답변받을 이메일을 입력해주세요.</span>
					</div>
					<div>
						<label for="location">제목*</label>
						<input type="text" name='qsTitle' id="title" style="width:300px; height:25px;">
					</div>
					<div class="request">
						<label for="request" class="class">요청사항*</label>
						<textarea class="mgtop" name='qsContent' id="content" rows="10" cols="100" style="resize: none"></textarea>
					</div>					
				</fieldset>
				<hr>
				<fieldset class="agreebox">
					<p>
						<input type="checkbox" name="agree" value="agree">
						<span>개인정보 수집 및 이용에 동의합니다.</span>
					</p>
				</fieldset>
				<div class="btn_faq">
						<input type="submit" value="문의하기" class="btn_faq2">
				</div>					
			</form>		

		</div>	
	</section>
</div> 



<script>

function inputCheck(){
// 핸드폰 
let phoneNumber = document.inquire.qsPhone;
//이메일 
let emailCheck =  document.inquire.qsEmail;
//제목 
let title = document.inquire.qsTitle;
//내용 
let content = document.inquire.qsContent;

// 핸드폰 유효성 검사 
let phonePattern = /^\d{3}\d{3,4}\d{4}$/;
//제목 유효성 검사 
let titleValue = title.value.replace(/(^\s*)|(\s*$)/g, ""); 
//내용 유효성 검사 
let contentValue = content.value.replace(/(^\s*)|(\s*$)/g, ""); 
//이메일 유효성 검사 
let emailPattern = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;

	// 핸드폰번호가 유호한지체크한다. 
	if(phonePattern.test(phoneNumber.value) == false){
		alert(" - 빼고 입력주세요. ex: 01012341234");
		return false;
	}
	// 이메일이 입력했는지 유효한지 체크한다. 
	if(emailCheck.value.length === 0){
		alert("이메일을 입력하세요.");
		return false;
	} else if(emailPattern.test(emailCheck.value)== false){
		alert("이메일을 다시 입력해주세요.");
		return false;
	} 
	//모임명 빈문자열 체크 
	if(titleValue.length <= 0) {		
		alert("제목을 입력해주세요.");
		return false;
	}
	//내용 빈문자열 체크 
	if(contentValue.length <= 0) {		
		alert("내용을 입력해주세요.");
		return false;
	}	
}
</script>

<%@ include file="../includes/footer.jsp"%>
</body>
</html>