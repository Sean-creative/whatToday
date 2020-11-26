<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../includes/header.jsp"%>

<link rel="stylesheet" href="<c:url value='../resources/css/inquire.css'/>">
<div class="cs_nav">
        <ul>
            <a href="/cs/faq">자주묻는질문</a>
            <a href="/cs/inquire">1:1문의사항</a>
        </ul>
    </div>
    <form role="form" action="/cs/faq" method="post" name="inquire" onsubmit="return inputCheck()">
    <div class="cs_all">
        <h3>1:1 문의하기 </h3>
        
        <div class="cs_text">
        <input type='hidden' name='usrNum' value="${usrNum}">
        
            <label>이름 : </label>
            <input type="text" name='qsName' class="name" value="${usrName}" readonly>

            <label>연락처 :</label>
            <input type="text" name='qsPhone' class="phone" placeholder="- 빼고 입력해주세요" id="phone">
            <br>
            <label>이메일 : </label>
            <input type="email" name='qsEmail' class="mgtop" id="email">
            <span class="spec">*답변받을 이메일 주소를 입력해주세요.</span>
            <br>
            
            <label>제목</label>
            <input type="text" name='qsTitle' class="mgtop" id="title">
            <br>
            
            <label>내용</label>
            <textarea class="mgtop" name='qsContent' id="content"></textarea>
            <br>

            <label>첨부파일</label>
            <input type="file" name='qsFile'>
            <br>
        </div>
        <input type="submit" value="보내기">       
    </div>
</form>
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