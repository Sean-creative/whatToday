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
            <input type="text" name='qsPhone' class="phone">
            <br>
            <label>이메일 : </label>
            <input type="email" name='qsEmail' class="mgtop">
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
	var phoneNumber = document.inquire.qsPhone;
	var email = document.inquire.qsEmail;
	var title = document.inquire.qsTitle;
	var content = document.inquire.qsContent;
	
	//핸드폰 번호 제한 
	var phonePattern = /^\d{3}\d{3,4}\d{4}$/;
	
	
	if(!phoneNumber.value){
		alert("번호를 입력해주세요.");
		return false;
	}
	
	if(phonePattern.test(phoneNumber.value) == false){
    	alert("핸드폰 번호 : 01012341234");
    	return false;
    	
    }
	
	if(!email.value){
		alert("이메일을 입력해주세요.");
		return false;
	}
	
	
	if(!title.value || title.value.length>30){
		alert("제목을 입주세요.");
		return false;
	}
	
	if(!content.value || content.value.length>30){
		alert("내용을 30자이내로 입력해주세요.");
		return false;
	}
	
}
</script>
<%@ include file="../includes/footer.jsp"%>
</body>
</html>