<%@page import="com.mchange.v2.cfg.PropertiesConfigSource.Parse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file = "../includes/header.jsp" %>
<link id="myCss" rel="stylesheet" type="text/css" href="<c:url value='/resources/css/mypage.css' />?after">
<div id="totalMenu">
	<nav id="navMenu">
		<div class="mypageMenu">
			<div class="uInfo">
				<img
					src="\resources\img\upload\<c:out value="${userVO.usrImgPath }"/>\<c:out value="${userVO.usrImg }"/>"><br>
				<h5>${userVO.usrName }</h5>
				<br>
				<h5>${userVO.usrId }</h5>
				<br>
				<h5>포인트</h5>
			</div>


			<div class="info">
				<h1>메뉴</h1>
				<form action="/mypage/main" method="get">
					<button class="btn1" type="submit" style="color: yellow;">마이페이지</button>
				</form>
				<button type="button" class="accordionBtn">모임관리</button>
				<div class="accordian">
					<form action="/mypage/myclub/main" method="get">
						<button type="submit">모임관리홈</button>
					</form>

					<form action="/mypage/myclub/main" method="post">
						<button type="submit">만남개설</button>
					</form>

					<form action="/mypage/myclub/userManage" method="get">
						<button type="submit">회원관리</button>
					</form>
				</div>
				<form action="/mypage/auth_edit" method="get">
					<button type="submit">회원정보수정</button>
				</form>
				<form action="/mypage/password" method="get">
					<button type="submit">비밀번호수정</button>
				</form>
				<form action="/mypage/auth_leave" method="get">
					<button type="submit">회원탈퇴하기</button>
				</form>
			</div>
		</div>
	</nav>
	<section id="wrapInfo">
		<h5 style="margin-left: 10%;">내가 가입한 정기모임</h5>
		<div id="myRegClubList" class="list">
		</div>
		<h5 style="margin-left: 10%;">내가 가입한 번개모임</h5>
		<div id="myThuClubList" class="list">
		</div>
		<h5 style="margin-left: 10%;">가입 대기중인 정기모임</h5>
		<div id="myWaitClubList" class="list">
		<c:forEach var="waitClub" items="${waitClub}">
  		<h5><c:out value="[${waitClub.cbType}] "/><c:out value="${waitClub.cbName}"/></h5>
		</c:forEach>
		</div>
		<h5 style="margin-left: 10%;">이전에 가입한 정기모임</h5>
		<div id="myPrevRegClubList" class="list">
		</div>
		<h5 style="margin-left: 10%;">이전에 가입한 번개모임</h5>
		<div id="myPrevThuClubList" class="list">
		</div>
	</section>
</div>
<script type="text/javascript" src="/resources/js/club.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
						let number = "${userVO.usrNum}";
						let prevClubList = $("#prevClubList");
						
						if ("${msg}" != "") {
							alert("${msg}");
						}

						const getMyClubList = function() {
							clubService.getMyClubList({usrNum : number},
											function(club) {
												console.log(number);
												console.log(club);
												let myClubReg = $("#myRegClubList");
												let myClubThu = $("#myThuClubList")
												let str = "";
												let str2= "";
												let cnt = 0;
												let cnt2= 0;
												for (let i = 0; i < club.length; i++) {
													if (club[i].cbType == "정기모임"
															&& number != club[i].cbLeaderNum) {
														str += "<div class='smallList' data-mycb='true' data-cbname ='"+club[i].cbName+"'data-cbtype='"+club[i].cbType+"' data-cbnum='"+club[i].cbNum+"'>["
																+ club[i].cbType
																+ "]"
																+ club[i].cbName
																+ "</div>";
														
													}
													if (club[i].cbType == "번개모임"
														&& number != club[i].cbLeaderNum) {
														str2 += "<div class='smallList' data-mycb='true' data-cbname ='"+club[i].cbName+"'data-cbtype='"+club[i].cbType+"' data-cbnum='"+club[i].cbNum+"'>["
														+ club[i].cbType
														+ "]"
														+ club[i].cbName
														+ "</div>";
												
													}
												}
												myClubReg.empty();
												myClubReg.append(str);
												myClubThu.empty();
												myClubThu.append(str2);
											});
						};
						getMyClubList();

						const changeClubMemStateMinus = function(e) {
							$
									.ajax({
										url : "/mypage/clubmanage/changeClubMemStateMinus",
										type : "PUT",
										data : JSON.stringify({
											usrNum : e.usrnum,
											cbNum : e.cbnum,
											cbName : e.cbname,
											cbType : e.cbtype,
											cbMbStResult : e.cbmbstresult
										}),
										dataType : "json",
										contentType : "application/json; charset=utf-8",
										success : function(data) {

										},
										complete : function(list) {
											insertClubJoinHistory(e);
										}
									});
						};

						const insertClubJoinHistory = function(e) {
							$
									.ajax({
										url : "/mypage/clubmanage/insertClubJoinHistory",
										type : "POST",
										data : JSON.stringify({
											usrNum : e.usrnum,
											cbNum : e.cbnum,
											cbName : e.cbname,
											cbType : e.cbtype,
											cbJoinStateResult : e.cbmbstresult
										}),
										dataType : "json",
										contentType : "application/json; charset=utf-8",
										success : function(data) {

										},
										complete : function(list) {
											getMyClubList();
											getPrevClubList();
										}
									});
						};

						const getPrevClubList = function() {
							clubService.getPrevClubList({usrNum : number},
											function(club) {
												console.log(prevClubList.val());
												let myPrevRegClubList = $("#myPrevRegClubList");
												let myPrevThuClubList = $("#myPrevThuClubList");
												let str = "";
												let str2 = "";
												let cnt = 0;
												let cnt2 = 0;
												for (let i = 0; i < club.length; i++) {

													if ("정기모임" == club[i].cbType) {
														str += "<div class='smallList' data-mycb='true' data-cbname ='"+club[i].cbName+"'data-cbtype='"+club[i].cbType+"' data-cbnum='"+club[i].cbNum+"'>["
														+ club[i].cbType
														+ "]"
														+ club[i].cbName
														+ "</div>";
														cnt++;
													}
													if ("번개모임" == club[i].cbType) {
														str2 += "<div class='smallList' data-mycb='true' data-cbname ='"+club[i].cbName+"'data-cbtype='"+club[i].cbType+"' data-cbnum='"+club[i].cbNum+"'>["
														+ club[i].cbType
														+ "]"
														+ club[i].cbName
														+ "</div>";
														cnt2++;
													}
												}
												
												myPrevRegClubList.empty();
												myPrevRegClubList.append(str);
												myPrevThuClubList.empty();
												myPrevThuClubList.append(str2);
												
											});
						};
						getPrevClubList();
						$(document)
								.on(
										"click",
										".cb",
										function(e) {
											console.log(e)
											let index = $(".cb").index(this);
											let data = $(".cb").eq(index)
													.data();

											console.log(index);
											console.log(data);

											var str = "";
											str += '<form name="joinClub" method="get">';
											str += '<input type="hidden" name="cbNum" value="'+data.cbnum+'">';
											str += '<button name="details" data-cbtype="'+data.cbtype+'">상세보기</button>';
											str += '</form>';
											if (data.mycb == true) {
												str += '<button name="drop" type="button" data-usrnum="'+number+'" data-cbtype="'+data.cbtype+'" data-cbnum="'+data.cbnum+'" data-cbmbstresult="모임탈퇴" data-cbname="'+data.cbname+'">탈퇴하기</button>'
											}
											let sWidth = window.innerWidth;
											let sHeight = window.innerHeight;

											let oWidth = $('.popupLayer')
													.width();
											let oHeight = $('.popupLayer')
													.height();

											// 레이어가 나타날 위치를 셋팅한다.
											let divLeft = e.clientX + 10;
											let divTop = e.clientY + 5;

											// 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치한다.
											if (divLeft + oWidth > sWidth)
												divLeft -= oWidth;
											if (divTop + oHeight > sHeight)
												divTop -= oHeight;

											// 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치.
											if (divLeft < 0)
												divLeft = 0;
											if (divTop < 0)
												divTop = 0;

											$(".popupLayer2").html(str);

											$('.popupLayer').css({
												"top" : divTop,
												"left" : divLeft,
												"position" : "absolute"
											}).show();
											$("button[name=details]")
													.click(
															function() {
																let form = $("form[name=joinClub]");
																let data = $(
																		"button[name=details]")
																		.data();
																console
																		.log(data);
																if (data.cbtype == "번개모임") {
																	console
																			.log("번개요");
																	url = "/thunder/info";
																} else {
																	console
																			.log("정기요");
																	url = "/regular/info";
																}
																form
																		.attr(
																				"action",
																				url);
															});

											$("button[name=drop]")
													.click(
															function() {

																let data = $(
																		"button[name=drop]")
																		.data();
																console
																		.log(data)
																changeClubMemStateMinus(data);
																$(".popupLayer")
																		.hide();
																alert("탈퇴하셨습니다.");
															});

										});
					});

	
	var acc = document.getElementsByClassName("accordionBtn");
	var i;

	for (i = 0; i < acc.length; i++) {
	  acc[i].addEventListener("click", function() {
	    this.classList.toggle("active");
	    var panel = this.nextElementSibling;
	    if (panel.style.display === "block") {
	      panel.style.display = "none";
	    } else {
	      panel.style.display = "block";
	    }
	  });
	}
</script>


    <%@include file = "../includes/footer.jsp" %>