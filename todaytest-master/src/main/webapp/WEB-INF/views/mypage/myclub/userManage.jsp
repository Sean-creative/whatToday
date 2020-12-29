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
				<h5>포인트 ${userVO.usrPoint }점</h5>
			</div>


			<div class="info">
				<h1>메뉴</h1>
				<form action="/mypage/main" method="get">
					<button type="submit">마이페이지</button>
				</form>
				
					<form action="/mypage/myclub/main" method="get">
						<button type="submit">모임관리</button>
					</form>

					<form action="/mypage/myclub/main" method="post">
						<button type="submit">만남개설</button>
					</form>

					<form action="/mypage/myclub/userManage" method="get">
						<button type="submit" style="color: yellow;">모임회원관리</button>
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
	<select name="clubList" id="clubList">
	</select>
	<div id="memberList">
			<table id="memberTable">
				<thead>
					<tr id ="tHead">
						<th>이름</th>
						<th>성별</th>
						<th>생일</th>
						<th>신청/가입일</th>
						<th>회원상태</th>
					</tr>
				</thead>
				<tfoot>
					<tr id="tFoot">
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
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript" src="//cdn.datatables.net/1.10.22/js/jquery.dataTables.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	let number = <c:out value="${usrNum}"/>;
	let clubList = $("#clubList");
	let wrapInfo3 = $("#wrapInfo3")
	let memberTable = $("#memberTable tbody");
	let memList = [];
	let type;
	let cbNum;
	let table;
	let data;
	clubService.getLeaderClubList({cbLeaderNum : number},function(club) {
		let str = "";
		console.log(club)
		if(club.length == 0){
			wrapInfo3.empty();
			wrapInfo3.append("<img style='width:50%; height:50%;'src='/resources/img/upload/default/simoo.png'>");
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
			return; 
		}
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
			"bInfo": false,
			"language": {
				"search" : "검색 : ",
				"lengthMenu" : "_MENU_ 개씩 보기",
				"paginate" : {
		            "first" : "첫 페이지",
		            "last" : "마지막 페이지",
		            "next" : "다음",
		            "previous" : "이전"
		        }
			},
			
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
				{"data": "cbJoinStateUpdateDate"},
				{"data": function (data, type, dataToSet) {
					console.log(data);
					let str = "";
								if(number == data.usrNum){
									str = "모임장"
								}else if(data.cbJoinStateResult == '승인대기'){
									str = "<select name='cbJoinStateResult' id='cbJoinStateResult'><option value='"+data.cbJoinStateResult+"'>"
									+ data.cbJoinStateResult
									+ "</option><option data-cbname='"+data.cbName+"' data-usrnum='"+data.usrNum+"' data-usrid='"+data.userVO.usrId+"' data-cbtype='"+data.cbType+"'data-usrname='"+data.usrName+"' data-cbnum='"+data.cbNum+"' value='가입승인'>가입승인</option><option data-cbname='"+data.cbName+"' data-usrnum='"+data.usrNum+"' data-usrid='"+data.userVO.usrId+"' data-cbtype='"+data.cbType+"'data-usrname='"+data.usrName+"' data-cbnum='"+data.cbNum+"'  value='승인거부'>승인거부</option>";
								}else if(data.cbJoinStateResult == '가입승인'){
									str = "<select name='cbJoinStateResult' id='cbJoinStateResult'><option value='"+data.cbJoinStateResult+"'>"
									+ data.cbJoinStateResult
									+ "</option><option data-cbname='"+data.cbName+"' data-usrnum='"+data.usrNum+"' data-usrid='"+data.userVO.usrId+"' data-cbtype='"+data.cbType+"'data-usrname='"+data.usrName+"' data-cbnum='"+data.cbNum+"' value='모임추방'>모임추방</option>"
								}
								return str;
					}	
				}
				],
			"columnDefs":[{
				"className": "dt-center", "targets": "_all"
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
			data : JSON.stringify({usrNum : e.usrnum,cbNum : e.cbnum, cbName : e.cbname, cbType : e.cbtype, cbMbStResult : e.cbJoinStateResult}),
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
			data : JSON.stringify({usrNum : e.usrnum,cbNum : e.cbnum,cbName : e.cbname,cbType : e.cbtype,cbMbStResult : e.cbJoinStateResult}),
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
													usrNum : e.usrnum,
													cbNum : e.cbnum,
													cbName : e.cbname,
													cbType : e.cbtype,
													cbJoinStateResult : e.cbJoinStateResult
												}),
										dataType : "json",
										contentType : "application/json; charset=utf-8",
										success : function(data) {

										},
										complete : function(list) {
											table.ajax.reload();
											console.log(socData.usrid);
											console.log(socData.cbname);

											if (socket.readyState != 1) {
												return;
											}
											if(socData.cbJoinStateResult == '가입승인'){
												socket.send(socData.usrid+ "," + "["+ socData.cbtype + "]"+ socData.cbname+ "에 가입되셨습니다."); //타겟, 내용.
											}else if(socData.cbJoinStateResult == '승인거부'){
												socket.send(socData.usrid+ "," + "["+ socData.cbtype + "]"+ socData.cbname+ "에서 가입 거부당하셨습니다."); //타겟, 내용.
											}else if (socData.cbJoinStateResult == '모임추방'){
												socket.send(socData.usrid+ "," + "["+ socData.cbtype + "]"+ socData.cbname+ "에서 추방되셨습니다."); //타겟, 내용.
											}
	
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
													usrNum : e.usrnum,
													usrName : e.usrname,
													cbNum : e.cbnum,
													cbName : e.cbname,
													cbType : e.cbtype,
													cbJoinStateResult : e.cbJoinStateResult
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

						$(document).on("change","select[name=cbJoinStateResult]",function() {
							let index = $("select[name=cbJoinStateResult]").index(this);
							let status = $("select[name=cbJoinStateResult]").eq(index).val();
							let data = $("select[name=cbJoinStateResult] option:selected").data();
							data.cbJoinStateResult = status;
							console.log(data);
							  if (status == '가입승인') {
								  swal({
									  title: "가입승인하시겠습니까?",
									  text: "승인하면 모임원으로 등록됩니다.",
									  icon: "warning",
									  buttons: true,
									  dangerMode: true,
									})
									.then((willDelete) => {
									  if (willDelete) {
										  changeClubMemStatePlus(data);
									    }
									   else {
									    swal("취소하셨습니다.");
									    table.ajax.reload(null,false);
									  }
							  })
									}
								 else if (status == '승인거부') {
									swal({
										  title: "승인거부하시겠습니까?",
										  text: "거부하시면 이 회원은 모임에 가입이 불가능합니다.",
										  icon: "warning",
										  buttons: true,
										  dangerMode: true,
										})
										.then((willDelete) => {
										  if (willDelete) {
											  insertClubJoinHistory(data);
										    }
										   else {
										    swal("취소하셨습니다.");
										    table.ajax.reload(null,false);
										  }
										})
								 }
									 else if (status == '모임추방') {
										swal({
											  title: "모임에서 추방하시겠습니까?",
											  text: "추방하시면 이 회원은 모임에 가입이 불가능합니다.",
											  icon: "warning",
											  buttons: true,
											  dangerMode: true,
											})
											.then((willDelete) => {
											  if (willDelete) {
												changeClubMemStateMinus(data);
											    }
											   else {
											    swal("취소하셨습니다.");
											    table.ajax.reload(null,false);
											  }
										}  )
									 }
							});
						

					});

	
</script>

    <%@include file = "../../includes/footer.jsp" %>