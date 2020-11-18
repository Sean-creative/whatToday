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
<div class ="info">
    <div class="pic">
    	<img src="${userVO.usrImg }" alt="My Image">
    <button>사진변경</button>
    </div>
	<div class="userInfo">
		<p>id=${userVO.usrId }</p>
		<p>name=${userVO.usrName }</p>
		<p>phone=${userVO.usrPhone }</p>	
	</div>
</div>
<div class ="info">
<div class ="clubInfoSmall">
<p>가입한 모임</p><br>
<c:forEach var="myClub" items="${myClub}">
   <c:out value="[${myClub.cbType}] "/><c:out value="${myClub.cbName}"/><br>
</c:forEach>
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
</section>


    <%@include file = "../includes/footer.jsp" %>