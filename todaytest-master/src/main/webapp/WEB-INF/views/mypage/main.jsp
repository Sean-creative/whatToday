<%@page import="com.mchange.v2.cfg.PropertiesConfigSource.Parse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file = "../includes/header.jsp" %>
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
<section id="wrap">
<div class ="info">
    <div class="pic">
    	<img style='width:100%; height:100%;' src="\resources\img\upload\<c:out value="${userVO.usrImgPath }"/>\<c:out value="${userVO.usrImg }"/>"
		alt="로딩중"/>
    </div>
	<div class="userInfo">
		<p>ID : ${userVO.usrId } </p>
		<p>NAME : ${userVO.usrName }</p>	
		<p>PHONE : ${userVO.usrPhone }</p>	
		<p>BIRTH : ${userVO.usrBirth }</p>
		<p>GENDER : ${userVO.usrGender }</p>
	</div>
</div>
<div class ="info">
<div class ="clubInfoSmall">
<select id="joinClubList">
	<option value="정기모임">가입한 정기모임</option>
	<option value="번개모임">가입한 번개모임</option>
</select>
<div id="myClub"></div>
</div>
<div class ="clubInfoSmall">
<p>가입 신청중인 정기 모임</p><br>
<c:forEach var="waitClub" items="${waitClub}">
   <c:out value="[${waitClub.cbType}] "/><c:out value="${waitClub.cbName}"/><br>
</c:forEach>
</div>
<div class ="clubInfoSmall">
<select id="prevClubList">
	<option value="정기모임">이전에 가입한 정기모임</option>
	<option value="번개모임">이전에 가입한 번개모임</option>
</select>
<div id="prevClub"></div>
</div>
</div>
<div class="popupLayer">
<div class="popupLayer2">
</div>
<span class="closeWin" style="cursor:pointer;font-size:2em;" title="닫기">X</span>

	
</div>

</section>

<script type="text/javascript" src="/resources/js/club.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	let number = "${userVO.usrNum}"
	let joinClubList = $("#joinClubList");
	let prevClubList = $("#prevClubList")
	
	if("${msg}" != ""){
		alert("${msg}");
	}
	
	const getMyClubList = function(){
		clubService.getMyClubList({usrNum:number},function(club){
			console.log(joinClubList.val());
			console.log(club);
			let myClub = $("#myClub");
			let str = "";
			let cnt = 0;
			for(let i = 0; i < club.length; i++){
				if(joinClubList.val() == club[i].cbType && number != club[i].cbLeaderNum){
					str += "<p class='cb' data-mycb='true' data-cbname ='"+club[i].cbName+"'data-cbtype='"+club[i].cbType+"' data-cbnum='"+club[i].cbNum+"'>["+club[i].cbType+"]"+club[i].cbName+"</p><br>";
					cnt++;
					}
				}
			if(cnt == 0){
				str += "가입한 모임이 없어요"
			}
			myClub.empty();
			myClub.append(str);
			});
	};getMyClubList();
	
	joinClubList.on("change", function(){
		getMyClubList();
		}
	);
	
	
	const changeClubMemState = function(e){
		$.ajax({
			url: "/mypage/clubmanage/changeClubMemState",
			type:"PUT",
			data: JSON.stringify({usrNum:e.usrnum,cbNum:e.cbnum,cbMbStResult:e.cbmbstresult}),
			dataType: "json",
			contentType : "application/json; charset=utf-8",
			success: function(data){ 
				
			},
			complete : function(list) {
				insertClubJoinHistory(e);
	           }
			});
		};
		const insertClubJoinHistory = function(e){
			$.ajax({
				url: "/mypage/clubmanage/insertClubJoinHistory",
				type:"POST",
				data: JSON.stringify({usrNum:e.usrnum,cbNum:e.cbnum,cbName:e.cbname,cbType:e.cbtype,cbMbStResult:e.cbmbstresult}),
				dataType: "json",
				contentType : "application/json; charset=utf-8",
				success: function(data){ 
					
				},
				complete : function(list) {
					getMyClubList();
					getPrevClubList();
		           }
				});
			};
		
	const getPrevClubList = function(){
		clubService.getPrevClubList({usrNum:number},function(club){
			console.log(prevClubList.val());
			let prevClub = $("#prevClub");
			let str = "";
			let cnt = 0;
			for(let i = 0; i < club.length; i++){
				
				if(prevClubList.val() == club[i].cbType){
					str += "<p class='cb' data-cbname ='"+club[i].cbName+"'data-cbtype='"+club[i].cbType+"' data-cbnum='"+club[i].cbNum+"'>["+club[i].cbType+"]"+club[i].cbName+"</p><br>";
					cnt++;
					}
				}
			if(cnt == 0){
				str += "이전에 가입한 모임이 없어요"
			}
			prevClub.empty();
			prevClub.append(str);
			});
		};
		getPrevClubList();
		
		prevClubList.on("change", function(){
			getPrevClubList();
			}
		);

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
	
	$(function(){

		$(".closeWin").click(function(e)
				{
			$(".popupLayer").hide()
			});
		});
	$(document).on("click", ".cb", function(e){
		console.log(e)
		let index = $(".cb").index(this);
		let data = $(".cb").eq(index).data();
		
		console.log(index);
		console.log(data);
		
		var str = "";
		str += '<form name="joinClub" method="get">';
		str += '<input type="hidden" name="cbNum" value="'+data.cbnum+'">';
		str += '<button name="details" data-cbtype="'+data.cbtype+'">상세보기</button>';
		str += '</form>';
		if(data.mycb == true){
			str += '<button name="drop" type="button" data-usrnum="'+number+'" data-cbtype="'+data.cbtype+'" data-cbnum="'+data.cbnum+'" data-cbmbstresult="모임탈퇴" data-cbname="'+data.cbname+'">탈퇴하기</button>'
			}
		let sWidth = window.innerWidth;
		let sHeight = window.innerHeight;

		let oWidth = $('.popupLayer').width();
		let oHeight = $('.popupLayer').height();

		// 레이어가 나타날 위치를 셋팅한다.
		let divLeft = e.clientX + 10;
		let divTop = e.clientY + 5;

		// 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치한다.
		if( divLeft + oWidth > sWidth ) divLeft -= oWidth;
		if( divTop + oHeight > sHeight ) divTop -= oHeight;

		// 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치.
		if( divLeft < 0 ) divLeft = 0;
		if( divTop < 0 ) divTop = 0;

		$(".popupLayer2").html(str);

		$('.popupLayer').css({
			"top": divTop,
			"left": divLeft,
			"position": "absolute"
			}).show();
		$("button[name=details]").click(function(){
			let form = $("form[name=joinClub]");
			let data = $("button[name=details]").data();
			console.log(data);
			if(data.cbtype == "번개모임"){
				console.log("번개요");
				url = "/thunder/info";
				}else{
					console.log("정기요");
					url = "/regular/info";
					}
			form.attr("action",url);
			});
	
			$("button[name=drop]").click(function(){
				
				let data = $("button[name=drop]").data();
				console.log(data)
				changeClubMemState(data);
				$(".popupLayer").hide();
				});
			});
	});


</script>


    <%@include file = "../includes/footer.jsp" %>