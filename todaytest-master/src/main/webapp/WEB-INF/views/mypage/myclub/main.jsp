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
					<button type="submit">마이페이지</button>
				</form>
				
				
					<form action="/mypage/myclub/main" method="get">
						<button type="submit" style="color: yellow;">모임관리</button>
					</form>


					<form action="/mypage/myclub/userManage" method="get">
						<button type="submit">모임회원관리</button>
					</form>
				
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
		<h3>내가 모임장인 정기모임</h3>
		<div id="myRegClubList" class="list" style="height: 182.4px;"></div>
		<h3>내가 모임장인 번개모임</h3>
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
			let cnt = 0;
			let cnt2 = 0;

			for(let i = 0; i < club.length; i++){
				if('정기모임' == club[i].cbType){
					str += "<div class='smallList'><img src='"+club[i].cbFile+"'/><button class='imgBtn detailBtn' data-cbtype='"+club[i].cbType+"' data-cbnum='"+club[i].cbNum+"'>수정하기</button><button class='imgBtn2 dropBtn' data-cbnum='"+club[i].cbNum+"'>폐쇄하기</button><p>"+club[i].cbName+"</p></div>";
					cnt++;	
				}else if('번개모임' == club[i].cbType){
						str2 += "<div class='smallList'><img src='"+club[i].cbFile+"'/><button class='imgBtn detailBtn' data-cbtype='"+club[i].cbType+"' data-cbnum='"+club[i].cbNum+"'>수정하기</button><button class='imgBtn2 dropBtn' data-cbnum='"+club[i].cbNum+"'>폐쇄하기</button><p>"+club[i].cbName+"</p></div>";
						cnt2++;
				}
				}
			
			if(cnt == 0){
				str = "<img class='noClub' src='/resources/img/upload/default/simoo.png'>내가 모임장인 정기모임이 없습니다.<a style='height:15%;' href='/regular/add'>🥺모임 개설하러가기.</a>"
			}
			if(cnt2 == 0){
				str2= "<img class='noClub' src='/resources/img/upload/default/simoo.png'>내가 모임장인 번개모임이 없습니다.<a style='height:15%;' href='/thunder/add'>🥺모임 개설하러가기.</a>"
			}
	
			
			if(cnt == 0 && cnt2 == 0){
				swal("모임장인 모임이 없어요", {
					  buttons: {
					    regular: {
					      text: "정기모임 개설",
					      value: "regular",
					    },
					    thunder: {
					    	text: "번개모임 개설",
						    value: "thunder",
					    },
					    cancel: "마이페이지 홈",
					  },
					})
					.then((value) => {
					  switch (value) {
					 
					    case "regular":
					    window.location.href='http://localhost:8088/regular/add';
					     break;
					 
					    case "thunder":
					    window.location.href='http://localhost:8088/thunder/add';
					      break;
					 
					    default:
					    window.location.href='http://localhost:8088/mypage/main';
					    break;
					  }
					});
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

</script>

    <%@include file = "../../includes/footer.jsp" %>