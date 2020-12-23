<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file = "../../includes/header.jsp" %>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/mypage.css' />?after">
<link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.22/css/jquery.dataTables.min.css">
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
				<h5>포인트 ${userVO.usrPoint }점l</h5>
			</div>


			<div class="info">
				<h1>메뉴</h1>
				<form action="/mypage/main" method="get">
					<button class="btn1" type="submit">마이페이지</button>
				</form>
				<button type="button" class="accordionBtn"  style="color: yellow;">모임관리</button>
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
	<select name="clubList" id="clubList">
	</select>
	<div id="memberList">
			<table id="memberTable">
				<thead>
					<tr>
						<th>이름</th>
						<th>성별</th>
						<th>생일</th>
						<th>신청/가입일</th>
						<th>회원상태</th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<th>이름</th>
						<th>성별</th>
						<th>생일</th>
						<th>신청/가입일</th>
						<th>회원상태</th>
					</tr>
				</tfoot>
			</table>

		</div>
</section>
</div>


<script type="text/javascript" src="/resources/js/club.js"></script>
<script type="text/javascript" src="//cdn.datatables.net/1.10.22/js/jquery.dataTables.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	let number = <c:out value="${usrNum}"/>;
	let clubList = $("#clubList");
	let memberTable = $("#memberTable tbody");
	let memList = [];
	let type;
	let cbNum;
	let table;
	let data;
	clubService.getLeaderClubList({cbLeaderNum : number},function(club) {
		let str = "";
		console.log(club)
		for (let i = 0; i < club.length; i++) {
			str += "<option value='"+club[i].cbNum+"' data-cbname='"+club[i].cbName+"' data-cbtype='"+club[i].cbType+"'>"
			+ "[" + club[i].cbType + "]" + club[i].cbName + "</option>";
			}
		clubList.append(str);
		cbNum = $("#clubList option:selected").val();
		console.log(cbNum);
		drawTable(cbNum,number);
	});
	
	const drawTable = function(cbNum,number){
		table =	$('#memberTable').DataTable({
			"order": [],
			"createdRow": function( row, data, dataIndex ) {
				
			},
			ajax: {
				'url':"/mypage/clubmanage/getClubManageMemList/"+ cbNum + ".json",
				'dataSrc':''
			},
			columns: [
				{"data": "usrName"},
				{"data": "userVO.usrGender"},
				{"data": "userVO.usrBirth"},
				{"data": "cbAppDate"},
				{"data": function (data, type, dataToSet) {
					let str = "";
								if(number == data.usrNum){
									str = "모임장"
								}else if(data.cbJoinStateResult == '승인대기'){
									str = "<select name='cbJoinStateResult' id='cbJoinStateResult'><option value='"+data.cbJoinStateResult+"'>"
									+ data.cbJoinStateResult
									+ "</option><option value='가입승인'>가입승인</option><option value='승인거부'>승인거부</option>";
								}else if(data.cbJoinStateResult == '가입승인'){
									str = "<select name='cbJoinStateResult' id='cbJoinStateResult'><option value='"+list[i].cbJoinStateResult+"'>"
									+ list[i].cbJoinStateResult
									+ "</option><option value='모임추방'>모임추방</option>"
								}
								return str;
					}	
				}
				],
			"columnDefs":[{
			}]
		});
	}
	$("#clubList").on("change", function() {
		cbNum = $("#clubList option:selected").val();
		table.destroy();
		drawTable(cbNum,number);
		})
	
	const changeClubMemStatePlus = function(e) {
		$.ajax({
			url : "/mypage/clubmanage/changeClubMemStatePlus",
			type : "PUT",
			data : JSON.stringify({usrNum : e.usrNum,cbNum : e.cbNum, cbName : e.cbName, cbType : e.cbType, cbMbStResult : e.cbJoinStateResult}),
			dataType : "json",
			contentType : "application/json; charset=utf-8",
			success : function(data) {
			
			},
			complete : function(list) {
				console.log(e);
				console.log("insert 직전");
				insertClubMember(e);
				}
			});
		};
	const changeClubMemStateMinus = function(e) {
		$.ajax({
			url : "/mypage/clubmanage/changeClubMemStateMinus",
			type : "PUT",
			data : JSON.stringify({usrNum : e.usrNum,cbNum : e.cbNum,cbName : e.cbName,cbType : e.cbType,cbMbStResult : e.cbJoinStateResult}),
			dataType : "json",
			contentType : "application/json; charset=utf-8",
			success : function(data) {
				
			},
			complete : function(list) {
				insertClubJoinHistory(e);
				let cbNum = $("#clubList option:selected").val();
				}
			});
		};

						const insertClubJoinHistory = function(e) {
							console.log(e);
							let socData = e;
							$
									.ajax({
										url : "/mypage/clubmanage/insertClubJoinHistory",
										type : "POST",
										data : JSON
												.stringify({
													usrNum : e.usrNum,
													cbNum : e.cbNum,
													cbName : e.cbName,
													cbType : e.cbType,
													cbJoinStateResult : e.cbJoinStateResult
												}),
										dataType : "json",
										contentType : "application/json; charset=utf-8",
										success : function(data) {

										},
										complete : function(list) {
											console.log(socData.usrId);
											console.log(socData.cbName);

											if (socket.readyState != 1) {
												return;
											}

											socket.send(socData.userVO.usrId
													+ "," + "["
													+ socData.cbType + "]"
													+ socData.cbName
													+ "에 가입되셨습니다."); //타겟, 내용.

										}
									});
						};

						const insertClubMember = function(e) {
							$
									.ajax({
										url : "/mypage/clubmanage/insertClubMember",
										type : "POST",
										data : JSON
												.stringify({
													usrNum : e.usrNum,
													usrName : e.usrName,
													cbNum : e.cbNum,
													cbName : e.cbName,
													cbType : e.cbType,
													cbJoinStateResult : e.cbJoinStateResult
												}),
										dataType : "json",
										contentType : "application/json; charset=utf-8",
										success : function(data) {

										},
										complete : function(list) {
											insertClubJoinHistory(e);
											let cbNum = $(
													"#clubList option:selected")
													.val();
											
										}
									});
						};

						$(document).on("change","select[name=cbJoinStateResult]",function() {
							let index = $("select[name=cbJoinStateResult]").index(this);
							let status = $("select[name=cbJoinStateResult]").eq(index).val();
							let data = $("#clubList option:selected").data();
							console.log(data);
							/* console.log(memList[index]);
							memList[index].cbJoinStateResult = status;
							console.log(memList[index].cbJoinStateResult);
							if (status == '가입승인') {
								changeClubMemStatePlus(memList[index]);
								alert("가입승인하셨습니다.");
								} else if (status == '승인거부') {
									insertClubJoinHistory(memList[index]);
									alert("승인거부하셨습니다.");
									} else if (status == '모임추방') {
										changeClubMemStateMinus(memList[index]);
										alert("모임추방하셨습니다.");
										} */
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