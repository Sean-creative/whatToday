<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file = "../../includes/header.jsp" %>
<link id="myCss" rel="stylesheet" type="text/css" href="<c:url value='/resources/css/mypage.css' />?after">
<nav id="navMenu">
<div class ="mypageMenu">
    <ul>
        <li>
            <form action="/mypage/main" method="get">
                <button class="btn1" type="submit">마이페이지</button>
            </form>
        </li>
            <li>
        <div class="dropdown2">
            <button type="button" class="dropbtn"  style="color: yellow;">모임관리</button>
            <div class="dropdown-content2">
            <ul>
                <li>
                <form action="/mypage/myclub/main" method="get">
            	<button type="submit"  style="color: orange;">모임관리홈</button>
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
        <form action="/mypage/password" method="get">
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
</nav>
<section id="wrapInfo">
<div class ="info">
<div class ="clubInfoSmall">
<select id="createClubList">
	<option value="정기모임">내가 모임장인 정기모임</option>
	<option value="번개모임">내가 모임장인 번개모임</option>
</select>
<div id="myClub"></div>
<form name="manageClub">
<input type="hidden" name="cbNum">
</form>
</div>
</div>
</section>

<script type="text/javascript" src="/resources/js/club.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	let number = <c:out value="${usrNum}"/>;
	let createClubList = $("#createClubList");
	let clubInfoSmall = $(".clubInfoSmall");
	const getLeaderClubList = function(){
		clubService.getLeaderClubList({cbLeaderNum:number},function(club){
			
			let str = "";
			let myClub = $("#myClub");
			console.log(club);
			
			myClub.empty();
			for(let i = 0; i < club.length; i++){
				if(createClubList.val() == club[i].cbType){
					str += "<p>"+"["+club[i].cbType+"] "+club[i].cbName+"<button name='modifyClub' data-cbtype='"+club[i].cbType+"'data-cbnum='"+club[i].cbNum+"'>수정하기</button><button name='closeClub' type='button' data-cbnum='"+club[i].cbNum+"'>폐쇄하기</button></p>";
					}
				}
			
			if(club.length == 0){
				clubInfoSmall.empty();
				clubInfoSmall.append("<h1>내가 모임장인 모임이 없어요</h1>");
			}
			myClub.append(str);
		});
	};getLeaderClubList();
	
	const shutClub = function(e){
		
		console.log(e);
		$.ajax({
			url: "/mypage/myclub/clubmanage/shutClub",
			type:"PUT",
			data: JSON.stringify({cbNum:e}),
			dataType: "json",
			contentType : "application/json; charset=utf-8",
			success: function(data){ 
				console.log(data);
			},
			complete: function(data){
				getLeaderClubList();
			}
			});
		};  
	
	createClubList.on("change",function(){
		getLeaderClubList();
	})
	
	
	
	
	$(".moreList").click(function(){
		$(".hideList").show();
		$(".moreList").hide();
		$(".closeList").show();
	})
	
	$(".closeList").click(function(){
		$(".hideList").hide();
		$(".moreList").show();
		$(".closeList").hide();
	})
	
	
	$(document).on("click", "button[name=modifyClub]", function(){
		let index = $("button[name=modifyClub]").index(this);
		let data = $("button[name=modifyClub]").eq(index).data();
		let form = $("form[name=manageClub]");
		let input = $("input[name=cbNum]");
		
		input.val(data.cbnum);
		
		if(data.cbtype == "정기모임"){
			console.log("정기요");
			url = "/regular/info";
		}else{
			console.log("번개요");
			url = "/thunder/modify";
		} 
		form.attr("action",url);
		form.submit();
	});
	
	
	

	$(document).on("click", "button[name=closeClub]", function(){
		let index = $("button[name=closeClub]").index(this);
		let data = $("button[name=closeClub]").eq(index).data();
		shutClub(data.cbnum);
		alert("폐쇄하셨습니다.")
	});
	});
</script>

    <%@include file = "../../includes/footer.jsp" %>