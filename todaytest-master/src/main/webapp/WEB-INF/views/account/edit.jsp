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
<form action="/account/editAction" method="post">
    <div class ="info"> <!-- 일단 하나하나씩 보내고 나중에 객체로 보내는거 공부해서 바꾸자 -->
        <div class="pic">
            <img src="${userVO.usrImg }" alt="My Image">
        <button>사진변경</button>
        </div>
        <div class="userInfo">
            <span>id </span><input type="text" readonly="readonly" value="<c:out value="${userVO.usrId }"/>"><br> 
            <span>비밀번호 </span><input type="password" readonly="readonly" value="<c:out value="${userVO.usrPwd }"/>"><br>
            <span>이름 </span><input type="text" name="usrName" value="<c:out value="${userVO.usrName }"/>"><br>
            <span>휴대전화번호 </span><input type="text" name="usrPhone" value="<c:out value="${userVO.usrPhone }"/>"><br>
        </div>
    
    </div>
    
    <div class ="info"> <!-- 여기는 나중에 data들어가면 구현합시다. -->
        <div class="userInfo" style="margin-left: 18.5%;">
             <h1>관심정보<span style="font-size: 15px; margin-left: 20px">개인별 맞춤정보 제공</span></h1>
             
             <ul style = "list-style: none;">
             <li>
               <!-- <select name="usrCity1">
                <option value="<c:out value='${userVO.usrCity1 }'/>">관심 지역 선택</option>
                </select>
                <select name="usrDistrict1">
                <option value="<c:out value='${userVO.usrDistrict1 }'/>">관심 지역 선택</option>
                </select>
                <select name="usrCity2">
                <option value="<c:out value='${userVO.usrCity2 }'/>">관심 지역 선택</option>
                </select>
                <select name="usrDistrict1">
                <option value="<c:out value='${userVO.usrDistrict2 }'/>">관심 지역 선택</option>
                </select> -->
             </li>
             <li>
                <select name="usrCategory1">

                </select>
                <select name="usrCategory2">
                </select>
             
             </li>
             
             </ul>

            
        </div>
        
    </div>
    <div>
    <button type="submit" class="modifyBtn"> 수정 </button>
    </div>
    </form>
</section>
<script type="text/javascript" src="/resources/js/category.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	var usrCat1 = $("select[name=usrCategory1]");
	var usrCat2 = $("select[name=usrCategory2]");
	var cat = 'C001';
	
	categoryService.getCategorylist({catClassificationCode:cat},function(list){
			console.log(list);
			var str='<option name="usrCategory1" value="<c:out value="${userVO.usrCategory1 }"/>">${userVO.usrCategory1 }</option>';
			for(var i = 0, len = list.length || 0; i< len; i++){
				if(list[i].catName == "${userVO.usrCategory1 }"){
					console.log(list[i].catName);
					continue;
				}
				console.log(list[i].catName);
				str += '<option name="usrCategory1" value="'+list[i].catName+'">'+list[i].catName+'</option>';
			}
			usrCat1.html(str);

		});


	categoryService.getCategorylist({catClassificationCode:cat},function(list){
		console.log(list);
		var str='<option name = "usrCategory2"value="<c:out value="${userVO.usrCategory2 }"/>">${userVO.usrCategory2 }</option>';
		for(var i = 0, len = list.length || 0; i< len; i++){
			if(list[i].catName == "${userVO.usrCategory2 }"){
				console.log(list[i].catName);
				continue;
			}
			str += '<option name="usrCategory2" value="'+list[i].catName+'">'+list[i].catName+'</option>';
		}
		usrCat2.html(str);
	
	});
});
</script>
    <%@include file = "../includes/footer.jsp" %>