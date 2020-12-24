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
				<h5>포인트 ${userVO.usrPoint }점</h5>
			</div>


			<div class="info">
				<h1>메뉴</h1>
				<form action="/mypage/main" method="get">
					<button class="btn1" type="submit" style="color: yellow;">마이페이지</button>
				</form>
				<button type="button" class="accordionBtn">모임관리</button>
				<div class="accordion">
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
		<h5>내가 가입한 정기모임</h5>
		<div id="myRegClubList" class="list">
		</div>
		<h5>내가 가입한 번개모임</h5>
		<div id="myThuClubList" class="list">
		</div>
		<h5>가입 대기중인 정기모임</h5>
		<div id="myWaitClubList" class="list">
		<c:forEach var="waitClub" items="${waitClub}">
		<div class='smallList'><img src='${waitClub.cbFile }'/><button class='imgBtn detailBtn2' data-cbname ='${waitClub.cbName }'data-cbtype='${waitClub.cbType }' data-cbnum='${waitClub.cbNum }'>상세보기</button><p>${waitClub.cbName }</p></div>
		</c:forEach>
		</div>
		<h5>이전에 가입한 정기모임</h5>
		<div id="myPrevRegClubList" class="list">
		</div>
		<h5>이전에 가입한 번개모임</h5>
		<div id="myPrevThuClubList" class="list">
		</div>
		<form id="detailForm" method="get">
			<input type="hidden" name="cbNum">
		</form>
	</section>
</div>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript" src="/resources/js/club.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
						let number = "${userVO.usrNum}";
						let prevClubList = $("#prevClubList");
						
						if ("${msg}" != "") {
							swal("${msg}", "", "success");
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
														str += "<div class='smallList'><img src='"+club[i].cbFile+"'/><button class='imgBtn detailBtn' data-cbname ='"+club[i].cbName+"'data-cbtype='"+club[i].cbType+"' data-cbnum='"+club[i].cbNum+"'>상세보기</button><button class='imgBtn2 dropBtn' data-usrnum='"+number+"' data-cbname ='"+club[i].cbName+"'data-cbtype='"+club[i].cbType+"' data-cbnum='"+club[i].cbNum+"' data-cbmbstresult='모임탈퇴'>탈퇴하기</button><p>"+club[i].cbName+"</p></div>";
														
													}
													if (club[i].cbType == "번개모임"
														&& number != club[i].cbLeaderNum) {
														str2 += "<div class='smallList'><img src='"+club[i].cbFile+"'/><button class='imgBtn detailBtn' data-cbname ='"+club[i].cbName+"'data-cbtype='"+club[i].cbType+"' data-cbnum='"+club[i].cbNum+"'>상세보기</button><button class='imgBtn2 dropBtn' data-usrnum='"+number+"' data-cbname ='"+club[i].cbName+"'data-cbtype='"+club[i].cbType+"' data-cbnum='"+club[i].cbNum+"' data-cbmbstresult='모임탈퇴'>탈퇴하기</button><p>"+club[i].cbName+"</p></div>";
												
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
							$.ajax({
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
							$.ajax({
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
														str += "<div class='smallList'><img src='"+club[i].cbFile+"'/><button class='imgBtn detailBtn2' data-cbname ='"+club[i].cbName+"'data-cbtype='"+club[i].cbType+"' data-cbnum='"+club[i].cbNum+"'>상세보기</button><p>"+club[i].cbName+"</p></div>";
														cnt++;
													}
													if ("번개모임" == club[i].cbType) {
														str2 += "<div class='smallList'><img src="+club[i].cbFile+"/><button class='imgBtn detailBtn2'  data-cbname ='"+club[i].cbName+"'data-cbtype='"+club[i].cbType+"' data-cbnum='"+club[i].cbNum+"'>상세보기</button><p>"+club[i].cbName+"</p></div>";
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
	
 	 $(document).on('mouseenter','.smallList', function() {
 		 let index = $('.smallList').index(this);
 		 $('.smallList img').eq(index).css("opacity","0");
 		 $('.imgBtn').eq(index).css("opacity","1");
 		 $('.imgBtn').eq(index).css("z-index","2");
 		 $('.imgBtn2').eq(index).css("opacity","1");
 		 $('.imgBtn2').eq(index).css("z-index","2");

		});  
 	$(document).on('mouseleave','.smallList', function() {
		 let index = $('.smallList').index(this);
		 $('.smallList img').eq(index).css("opacity","1");
		 $('.imgBtn').eq(index).css("opacity","0");
		 $('.imgBtn').eq(index).css("z-index","0");
		 $('.imgBtn2').eq(index).css("opacity","0");
		 $('.imgBtn2').eq(index).css("z-index","0");
		});  
	$(document).on('click','.detailBtn,.detailBtn2',function(){
		let data = $(this).data();
		let url = "";
		let detailForm = $("#detailForm");
		let inputNum = $("input[name=cbNum]");
		if(data.cbtype == '정기모임'){
			url = "/regular/info";
		}else if(data.cbtype == '번개모임'){
			url = "/thunder/info";
		}
		console.log(data.cbnum);
		inputNum.val(data.cbnum);
		detailForm.attr("action",url);
		detailForm.submit();
		
	})
	$(document).on('click','.dropBtn',function(){
		let data = $(this).data();
		changeClubMemStateMinus(data);
	})

	
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
	});
</script>


    <%@include file = "../includes/footer.jsp" %>