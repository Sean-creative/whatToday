<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file = "../../includes/header.jsp" %>

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
<div class ="clubInfoSmall">
<p>개설한 모임</p><br>
<c:forEach var="clubVO" items="${clubVO}">
   <c:out value="[${clubVO.cbType}] "/><c:out value="${clubVO.cbName}"/><br>
   <form name="modifyForm" method="post">
   <input type="hidden" name="cbType" value="<c:out value="${clubVO.cbType}"/>">
   <input type="hidden" name="cbName" value="<c:out value="${clubVO.cbName}"/>">
   <input type="hidden" name="cbLeaderNum" value="<c:out value="${clubVO.cbLeaderNum}"/>">
   <button name="modifyClub" type="submit">수정</button>  <!-- 이거 아직 못씀 이거 띵킹하면 진도안나감 아마 -->
   </form>
</c:forEach>
</div>

</div>
</section>

<script type="text/javascript" src="/resources/js/club.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	var number = '<c:out value="${clubVO[0].cbLeaderNum }"/>'
	var clubInfoSmall = $(".clubInfoSmall")
	if(number == ""){
		clubInfoSmall.html('<p>개설한 모임이 없어요</p>')
	}
	
	
	$("button[name=modifyClub]").click(function(){
		var index = $("button[name=modifyClub]").index(this);
		var type = $("input[name=cbType]").eq(index).val();
		var form = $("form[name=modifyForm]").eq(index);
		var url;
		if(type == "정기모임"){
			console.log("정기요");
			url = "/account/myclub/regularEdit";
		}else{
			console.log("번개요");
			url = "/account/myclub/thunderEdit";
		}
		form.attr("action",url);
	})
	});
</script>

    <%@include file = "../../includes/footer.jsp" %>