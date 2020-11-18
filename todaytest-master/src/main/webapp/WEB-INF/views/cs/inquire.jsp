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
    <form role="form" action="/cs/faq" method="post">
    <div class="cs_all">
        <h3>1:1 문의하기 </h3>
        
        <div class="cs_text">
        <input type='hidden' name='usrNum' value="${usrNum}">
        
            <label>이름 : </label>
            <input type="text" name='qsName' class="name" value="${usrName}">

            <label>연락처 :</label>
            <input type="text" name='qsPhone' class="phone">
            <br>
            <label>이메일 : </label>
            <input type="email" name='qsEmail' class="mgtop">
            <span class="spec">*답변받을 이메일 주소를 입력해주세요.</span>
            <br>
            
            <label>제목</label>
            <input type="text" name='qsTitle' class="mgtop">
            <br>
            
            <label>내용</label>
            <textarea class="mgtop" name='qsContent'></textarea>
            <br>

            <label>첨부파일</label>
            <input type="file" name='qsFile'>
            <br>
        </div>
        <input type="submit" value="보내기">       
    </div>
</form>

<%@ include file="../includes/footer.jsp"%>
</body>
</html>