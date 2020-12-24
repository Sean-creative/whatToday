<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file = "../../includes/header.jsp" %>
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
					<button class="btn1" type="submit">마이페이지</button>
				</form>
				<button type="button" class="accordionBtn" style="color: yellow;">모임관리</button>
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

	<section id="wrapInfo3">
		<h5>내가 개설한 정기모임</h5>
		<div id="myRegClubList" class="list" style="height: 182.4px;"></div>
		<h5>내가 개설한 번개모임</h5>
		<div id="myThuClubList" class="list" style="height: 182.4px;"></div>
		<form name="manageClub">
			<input type="hidden" name="cbNum">
		</form>

	</section>
</div>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript" src="/resources/js/club.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	let number = <c:out value="${usrNum}"/>;
	let createClubList = $("#createClubList");
	let clubInfoSmall = $(".clubInfoSmall");
	const getLeaderClubList = function(){
		clubService.getLeaderClubList({cbLeaderNum:number},function(club){
			
			let str = "";
			let str2= "";
			let myClubReg = $("#myRegClubList");
			let myClubThu = $("#myThuClubList");
			console.log(club);

			for(let i = 0; i < club.length; i++){
				if('정기모임' == club[i].cbType){
					str += "<div class='smallList'><img src='"+club[i].cbFile+"'/><button class='imgBtn detailBtn' data-cbtype='"+club[i].cbType+"' data-cbnum='"+club[i].cbNum+"'>수정하기</button><button class='imgBtn2 dropBtn' data-cbnum='"+club[i].cbNum+"'>폐쇄하기</button><p>"+club[i].cbName+"</p></div>";
					}else if('번개모임' == club[i].cbType){
						str2 += "<div class='smallList'><img src='"+club[i].cbFile+"'/><button class='imgBtn detailBtn' data-cbtype='"+club[i].cbType+"' data-cbnum='"+club[i].cbNum+"'>수정하기</button><button class='imgBtn2 dropBtn' data-cbnum='"+club[i].cbNum+"'>폐쇄하기</button><p>"+club[i].cbName+"</p></div>";
					}
				}
			myClubReg.empty();
			myClubReg.append(str);
			myClubThu.empty();
			myClubThu.append(str2);

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

	
	
	$(document).on("click", ".detailBtn", function(){
		let index = $(".detailBtn").index(this);
		let data = $(".detailBtn").eq(index).data();
		let form = $("form[name=manageClub]");
		let input = $("input[name=cbNum]");
		console.log(data);
		input.val(data.cbnum);
		
 		if(data.cbtype == "정기모임"){
			console.log("정기요");
			url = "/regular/update";
		}else{
			console.log("번개요");
			url = "/thunder/modify";
		} 
		form.attr("action",url);
		form.submit(); 
	});
	
	
	

	$(document).on("click", ".dropBtn", function(){
		let index = $(".dropBtn").index(this);
		let data = $(".dropBtn").eq(index).data();
		
		swal({
  		  title: "정말 폐쇄하시겠어요?",
  		  text: "정말 정말 정말로?",
  		  icon: "warning",
  		  buttons: true,
  		  dangerMode: true,
  		})
  		.then((willDelete) => {
  		  if (willDelete) {
  			shutClub(data.cbnum);
  		    } else {
  		    swal("폐쇄가 취소됐습니다.");
  		  }
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

    <%@include file = "../../includes/footer.jsp" %>