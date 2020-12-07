<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file = "../../includes/header.jsp" %>

<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/mypage.css' />?after">

<nav id="nav">
<div class ="menu">
    <ul>
        <li>
            <form action="/mypage/main" method="get">
                <button class="btn1" type="submit"  style="color: yellow;">마이페이지</button>
            </form>
        </li>
            <li>
        <div class="dropdown">
            <button type="button" class="dropbtn">모임관리</button>
            <div class="dropdown-content">
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
        <form action="/mypage/password" method="get" >
            <button type="submit">비밀번호수정</button>
        </form>
    </li>
    <li>
        <form action="/mypage/auth_leave" method="get">
            <button type="submit">회원탈퇴하기</button>
        </form>
        
        </li>
    </ul>

</div>
</nav>2
<section id="wrap">
	<select name="clubList" id="clubList">
	
	</select>
</section>

<script type="text/javascript" src="/resources/js/club.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	let number = <c:out value="${usrNum}"/>;
	let clubList = $("#clubList")
	clubService.getMyCreateClubList({cbLeaderNum:number},function(club){
		for(let i = 0; i < club.length; i++){
			console.log(club[i]);
		}
	})

});
</script>

    <%@include file = "../../includes/footer.jsp" %>