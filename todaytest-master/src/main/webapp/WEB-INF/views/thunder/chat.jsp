<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 작성자 : 김선우 -->
<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" type="text/css" href="/resources/css/thunderInfo.css">
<link rel="stylesheet" type="text/css" href="/resources/css/kakaoMap.css">
<link rel="stylesheet" href="../resources/css/regularChat.css">




<!--  번개 모임 상세페이지 -->
<section id="wrap">



	<div id="regularInfo">
		<div id="detail">
			<div id="leftinfo">
				<div>
					<p id="topInfo">#${clubVO.cbSubcat} #${clubVO.cbDistrict}</p>
				</div>
				<div>
					<p id="topcbName">${clubVO.cbName}</p>
				</div>
				<img src="${clubVO.cbFile}" class="thumbImg" />

				<div id=banner>
					<ul>
						<li><a href="javascript:void(0);">정보</a></li>
						<!--a태그의 페이지이동 기능 무효화 -->
						<li><a href="/thunder/chat?cbNum=<c:out value="${clubVO.cbNum}" />">채팅</a></li>
						<!--a태그의 페이지이동 기능 무효화 및 클릭시 경고창 -->
					</ul>
				</div>

				<!-- ##### 번개모임 채팅창 (지영) ##### -->
				<div id=chatroom>
				<input type="hidden" id="cbNum" value="${cbNum }" placeholder="모임 번호" />
				<section class="msger">
					<!-- 모임 개설자만 채팅방을 만들 수 있다. -->
					<div id ="makeChat">
						<button id="make"> + 모임 채팅방만들기 </button>
					</div>
					<div id = "enterChat">
						<input type="hidden" id="name" class="form-inline" placeholder="${usrName }" value="${usrName }" readonly="readonly">
						<button id="enter"> + 채팅창 들어가기</button>
					</div>
					
					<div class="msger-chat" id="chat">
					</div>
						
					<div class="msger-inputarea">
						<input type="text" class="msger-input" id="message" placeholder="메세지를 입력해주세요">
					<button type="submit" class="msger-send-btn" id="send">전송</button>
					</div>
				</section>
				</div><!-- END chatroom -->
		
			</div><!-- END leftinfo -->
			





			<div id="rightinfo" class="rightinfo">
				<div class="contentup">
					<div class="contentl">
						<p>⚡️작성자는?</p>
					</div>
				</div>
				
				<div style="margin: 0 10px">
					<div class="contentmid">
						
						<p class="clubb"> <c:out value="${userVO.usrName}" /> </p>						
						<p class="clubb">(<c:out value="${userVO.usrId}" />)</p>

						<br> <img src="../resources/img/thunderHuman.png"> 
						
						<div id="appDate">
						<fmt:parseDate var="dateString" value="${clubVO.thunderDetailVO.cbAppPeriod}" pattern="yyyy-MM-dd'T'HH:mm" />
						<fmt:formatDate value="${dateString}" pattern="yyyy년 M월 d일  E'요일' a h시  m분 까지 신청" />
						</div>

						<br>
						
							<!-- 로그인한유저와 모임장이 같은 사람이 아니라면 버튼을 보여줘야한다. -->
						<c:if test="${usrNum != clubVO.cbLeaderNum}">
							<button class="btn btn-info" data-oper='join' id="join">
								<!-- joinState - 모임추방, 모임만료, 모임탈퇴, 가입승인, Null (아직 데이터 넣기 전) -->
								<!-- 모임 마감 까지도 아니면, 모임 가입하기 보여주는 것으로 한다. 그러면 순서가 맞음 -->
								<c:choose>
									<c:when test="${joinState eq '가입승인'}">모임 나가기</c:when>
									<c:when test="${joinState eq '모임추방'}">모임 가입불가</c:when>
									<c:when test="${clubVO.cbCurMbnum == clubVO.cbMbnum}">모임 정원 초과</c:when>

									<c:when test="${joinState eq '모임탈퇴' || joinState == null}">모임 가입하기</c:when>
								</c:choose>
							</button>
						</c:if>

						<!-- 지금 로그인된 유저의 정보와 개설자의 번호가 일치하면(=같은사람 이라면) modify 버튼을 보여준다.-->
						<c:if test="${usrNum eq clubVO.cbLeaderNum}">
							<button class="btn btn-default" data-oper='modify'>수정</button>
						</c:if>
						<button class="btn btn-info" data-oper='list'>목록</button>


					</div>
				</div>
			</div>
			<!-- rightinfo END -->
		</div>
		<!-- END detail -->


	</div>
	<!-- END regularInfo -->











	<!-- controller로 넘어가야하는 정보들 -->
	<form id='operForm' action="/thunder/modify" method="get">
		<input type='hidden' id='cbNum' name='cbNum' value='<c:out value="${clubVO.cbNum}"/>'>
		<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
		<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
		<input type='hidden' name='category' value='<c:out value="${cri.category}"/>'>
		<input type='hidden' name='subclass' value='<c:out value="${cri.subclass}"/>'>
		<input type='hidden' name='city' value='<c:out value="${cri.city}"/>'>
		<input type='hidden' name='district' value='<c:out value="${cri.district}"/>'>
		<input type='hidden' name='searchBy' value='<c:out value="${cri.searchBy}"/>'>
		<input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>
		<input type='hidden' name='orderBy' value='<c:out value="${cri.orderBy}"/>'>

		<input type="hidden" name="userLatitude" value='<c:out value="${cri.userLatitude}"/>'>
		<input type="hidden" name="userLongitude" value='<c:out value="${cri.userLongitude}"/>'>

		<input type='hidden' name='joinState' value='<c:out value="${joinState}"/>'>
	</form>
</section>





<script>
	window.onscroll = function() {
		myFunction()
	};

	var right = document.getElementById("rightinfo");
	var sticky = rightinfo.offsetTop;

	function myFunction() {
		if (window.pageYOffset > sticky) {
			rightinfo.classList.add("sticky");
		} else {
			rightinfo.classList.remove("sticky");
		}
	}
</script>



<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.14.1/moment.min.js"></script> -->
<script type="text/javascript">
	$(document).ready(
			function() {

				console.log("<c:out value="${clubVO}" />")
				let operForm = $("#operForm");

				$("button[data-oper='join']").on(
						"click",
						function(e) {
							e.preventDefault();
							operForm.attr("action", "/thunder/join").attr(
									"method", "post").submit();
						});

				$("button[data-oper='modify']").on("click", function(e) {
					e.preventDefault();
					operForm.attr("action", "/thunder/modify").submit();
				});

				$("button[data-oper='list']").on("click", function(e) {
					e.preventDefault();
					console.log('button - list click');
					/* operForm.find("#cbNum").remove(); */
					operForm.attr("action", "/thunder/list")
					console.log("operForm.attr");

					operForm.submit();
				});
			});

	// * 신청하기, 신청 취소하기 버튼 로직 *
	// A. 신청하기
	// 1. 개설한 사람이 아니다.
	// 2. 신청을 하지 않은 사람 (로그인 자체는 컨트롤러 단에서 해결 )
	// 조건을 위해 필요 한 것 -> 개설한 사람의 번호, 로그인한 사람의 번호
	/* 		30번(로그인한 사람의 번호)이 신청을 했는지 안했는지 어떻게 알지? -> 모임멤버 테이블에 CBMBSTRESULT가 '활동중' 이어야 한다.
	 if ( (개설한 사람의 번호 != 로그인한 사람의 번호) && (CBMBSTRESULT != '활동중') )
	
	 val = '신청하기'
	 */

	// B. 신청 취소하기
	// 1. 개설한한 사람이 아니다.
	// 2. 신청을 한 사람
	/* 2차 구현 예정........... */

	console.log($("#join").text().trim());
	if ($("#join").text().trim() == '모임 나가기') {
		//모임에 참석중일 때
		document.getElementById("plusDiv").style.display = "block";
		document.getElementById("pulsButton").value = "🐵";
	} else if ($("#join").text().trim() == '모임 가입하기') {
		//모임에 참석 중이 아닐 때
		document.getElementById("plusDiv").style.display = "none";
		document.getElementById("plus").style.display = 'none';

	} else if ($("#join").text().trim() == '모임 가입불가'
			|| $("#join").text().trim() == '모임 정원 초과') {
		//모임에 가입이 불가능 할 때
		document.getElementById('join').disabled = 'disabled';
		document.getElementById("plusDiv").style.display = "none";
		document.getElementById("plus").style.display = 'none'
	}

	function viewPlus() {

		if (document.getElementById("plus").style.display == 'none') {
			document.getElementById("plus").style.display = 'block';
			document.getElementById("pulsButton").innerHTML = "🙊";
		} else {
			document.getElementById("plus").style.display = 'none';
			document.getElementById("pulsButton").innerHTML = "🐵";
		}
	}

	/* 해시태그 구현관련!! */
	let stringHash = '${clubVO.cbHashtag}';
	console.log(stringHash);

	let arrayHash = stringHash.split(',');
	console.log(arrayHash);

	for ( let i in arrayHash) {
		if (arrayHash[i] != "") {
			$("#tag-list").append(
					"<li class='tag-item'>" + arrayHash[i] + "</li>");
		}
	}
</script>

<script type="text/javascript">
// ##### 번개모임 채팅창 (지영) #####
$(document).ready(function() {
	var webSocket;
	
	var cbNum = document.getElementById('cbNum').value;
	var usrName ="${usrName}";
	var usrNum = "${usrNum}";
	var cbLeaderNum = "${clubVO.cbLeaderNum}";	
	
	var make = document.getElementById("makeChat");
	var enter = document.getElementById("enterChat");

	// 모임 개설자만 채팅방을 개설 할 수 있다.
	if(usrNum==cbLeaderNum){
		make.style.display = "block";
	}
	// 모임 가입자는 채팅에 참여 할 수 있다.
	else{
		enter.style.display = "block";
	}
	
	// 모임 개설자도 모임 개설후 채팅에 입장 버튼을 클릭해야함.
	if(make!=null){
		make.addEventListener("click",function() {
			make.style.display = "none";
			enter.style.display = "block";
			connect();
			onOpen();
		});
	}
	
	// 입장버튼을 누르면 입장버튼 사라지게..
	enter.addEventListener("click",function() {
		enter.style.display = "none";
		connect();
	});
	
	$('#send').click(function() {
		let message = document.getElementById("message").value;
		// 나
		$('#chat').append('<div class="msg right-msg"><div class="msg-bubble"><div class="msg-text" id ="mytext">'+ message+ ' </div></div></div></div>');
		send();
		message = "";
	});
	
	function connect() {
		webSocket = new WebSocket("ws://localhost:8088/echo");
		webSocket.onopen = onOpen;
		webSocket.onclose = onClose;
		webSocket.onmessage = onMessage;
	}
	
	function disconnect() {
		webSocket.close();
	}
	
	function send() {
		let msg = document.getElementById("message").value;
		webSocket.send("입장," + cbNum + "," + usrName + ","+ msg); //타겟, 내용.
		document.getElementById("message").value = "";
	}
	
	function onOpen() {
		webSocket.send("개설," + cbNum + "," + usrName + ",방만들기.");
	}

	function onMessage(e) {
		let data = e.data;
		let arr = data.split(":");
		let sender = arr[0];
		let msg = arr[1];
		console.log("sender:  " + sender);
		$('#chat').append('<div class="msg left-msg"><div class="msg-img" style="background-image: url(https://image.flaticon.com/icons/svg/145/145867.svg)"></div><div id = "leftMsg"><div class="msg-info-name">'
							+ sender
							+ '</div><div class="msg-bubble"><div class="msg-text">'
							+ msg
							+ '</div></div></div>');
	}
	
	function onClose() {
	}

});
</script>


<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e19ea28cff4b871b68b2fabda7855cab&libraries=services,clusterer,drawing"></script>

<script type="text/javascript" src="/resources/js/kakaoMap.js"></script>




<%@include file="../includes/footer.jsp"%>