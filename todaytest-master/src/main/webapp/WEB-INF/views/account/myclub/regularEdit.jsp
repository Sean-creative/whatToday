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
    
    <select id="clubList" name = "clubList">
    
     
    </select>
    
    <div id="clubInfo"></div>
    
    </section>
<script type="text/javascript" src="/resources/js/club.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	var number = '<c:out value="${clubVO.cbLeaderNum }"/>'
	var clubList = $("#clubList");
	var clubInfo = $("#clubInfo");
	clubService.getList({cbLeaderNum:number},function(list){

		console.log(list);
		var str="";
		if(list == null || list.length == 0){
			alert("개설한 모임이 없어요");
			return;
		}
			str += '<option value="">개설한 모임을 선택하세요</option>';
		for(var i = 0, len = list.length || 0; i< len; i++){
			if(list[i].cbType == "번개모임"){
				console.log("번개모임");
				continue;
			}
			str += '<option value="'+list[i].cbNum+'">'+"["+list[i].cbType+"]"+list[i].cbName+'</option>';
		}
		clubList.html(str);
	})
	
	clubList.change(function(){
		var clubNum = $(this).val();
		var str="";
		console.log("누른거번호"+clubNum);
		clubService.getList({cbLeaderNum:number},function(list){

			for(var i = 0, len = list.length || 0; i< len; i++){
				if(list[i].cbLeaderNum = clubNum){
					str += '<input type="text" value="'+list[i].cbName+'">';
					str += '<input type="text" value="'+list[i].cbDetailContent+'">';
					str += '<input type="text" value="'+list[i].cbCategory+'">';
					str += '<input type="text" value="'+list[i].cbHashtag+'">';
					str += '<button>이거누르면 수정한 모임 상세페이지로 이동시킬거임</button>'
					
				}
				
			}
			clubInfo.html(str);
			
		})
		
		
	})
	
});
</script>

    <%@include file = "../../includes/footer.jsp" %>
