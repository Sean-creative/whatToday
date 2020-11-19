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
   <form name="manageClub" method="get">
   <input type="hidden" name="cbType" value="<c:out value="${clubVO.cbType}"/>">
   <input type="hidden" name="cbName" value="<c:out value="${clubVO.cbName}"/>">
   <input type="hidden" name="cbLeaderNum" value="<c:out value="${clubVO.cbLeaderNum}"/>">
   <input type="hidden" name="cbNum" value="<c:out value="${clubVO.cbNum}"/>">
   <button name="modifyClub" type="submit">수정</button> 
   <button name="closeClub" type="submit">모임폐쇄 아직 구현 X</button> 
   </form>
</c:forEach>
</div>

</div>
</section>

<script type="text/javascript" src="/resources/js/club.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	let number = '<c:out value="${clubVO[0].cbLeaderNum }"/>'
	let clubInfoSmall = $(".clubInfoSmall")
	if(number == ""){
		clubInfoSmall.html('<p>개설한 모임이 없어요</p>')
	}
	$("button[name=modifyClub]").click(function(){
		let index = $("button[name=modifyClub]").index(this);
		let type = $("input[name=cbType]").eq(index).val();
		let form = $("form[name=manageClub]").eq(index);
		let cbNum = $("input[name=cbNum]").eq(index).val();
		let url;
		if(type == "정기모임" || type == "정기"){
			console.log("정기요");
			url = "/regular/info?cbNum="+cbNum;
		}else{
			console.log("번개요");
			url = "/thunder/info/?cbNum="+cbNum;
		}
		form.attr("action",url);
	});
	$("button[name=closeClub]").click(function(){
		let index = $("button[name=modifyClub]").index(this);
		let type = $("input[name=cbType]").eq(index).val();
		let form = $("form[name=manageClub]").eq(index);
	});
	});
</script>

    <%@include file = "../../includes/footer.jsp" %>