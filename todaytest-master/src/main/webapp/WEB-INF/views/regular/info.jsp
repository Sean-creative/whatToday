<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" href="../resources/css/clubInfoStyle.css">

<div id="banner">
	<ul>
		<li><a href="javascript:void(0);">정보</a></li>
		<!--a태그의 페이지이동 기능 무효화 -->
		<li><a href="/regular/board?cbNum=<c:out value="${club.cbNum}" />">게시판</a></li>
		<!--cbNum(모임번호)을 가지고 게시판페이지이동-->
		<li><a href="javascript:void(0);" onClick="alert('곧 오픈됩니다!'); return false;">채팅</a></li>
		<!--a태그의 페이지이동 기능 무효화 및 클릭시 경고창 -->
	</ul>
</div>

<div id="body">
	<div id=up>
		해시태그 -
		<c:out value="${club.cbHashtag}" />
	</div>
	<div id=mid>
		[모임명]
		<c:out value="${club.cbName}" />
	</div>
	<div id=dow>
		<img src="/resources/img/clubsample.jpg" alt='sample' align="left"> 한줄소개 -
		<c:out value="${club.cbIntro}" />
		<br> 상세내용 -
		<c:out value="${club.cbDetailContent}" />
	</div>
	<div>
		개설자 -
		<c:out value="${club.cbLeaderName }" />
	</div>
	<!-- <button type="submit" onclick="document.getElementById('id01').style.display='none'">가입하기</button> -->
	<!-- <button onclick="javascript:join();">가입하기</button> -->


	<!-- 로그인 유저의 정보와 개설자의 번호가 일치하지 않으면 버튼을 보여줘야한다. -->
	<c:if test="${usrNum != club.cbLeaderNum}">
		<button style="margin-left: 230px; padding: 5px 80px; margin-bottom: 30px;" class="btn btn-info" data-oper='join' id="join">
			<!-- joinState - 모임추방, 모임만료, 모임탈퇴, 가입승인, Null (아직 데이터 넣기 전) -->
			<!-- 모임 마감 까지도 아니면, 모임 가입하기 보여주는 것으로 한다. 그러면 순서가 맞음 -->
			<c:choose>
				<c:when test="${joinState eq '가입승인'}">모임 나가기</c:when>
				<c:when test="${joinState eq '모임추방' || joinState eq '승인거부' }">모임 가입불가</c:when>
				<c:when test="${joinState eq '승인대기'}">승인 대기 중</c:when>

				<c:when test="${club.cbMbNum == club.cbCurMbNum}">모임 정원 초과</c:when>
				<c:when test="${joinState eq '모임탈퇴' || joinState == null}">모임 가입하기</c:when>
			</c:choose>
		</button>
	</c:if>


	<form action="#" method="get" id="meeting-form">
		<%-- <c:choose>
						<c:when test="${ClubMemberVO.usrNum == clubVO.cbLeaderNum}">모임장</c:when>
						<c:otherwise>모임원</c:otherwise>
					</c:choose> --%>
		<div id="plus" style="float: right; border: 1px solid; margin: 30px auto;">
			<c:forEach items="${meetingList}" var="MeetingVO">
				<div style="text-align: center; border: 1px solid; margin: 0px; padding: 10px; font-size: 30px;">

					<br> ${MeetingVO.mtName} (${MeetingVO.mtCurMbNum}/${MeetingVO.mtMbNum}명) <br>
					<fmt:parseDate var="dateString" value="${MeetingVO.mtStartDate}" pattern="yyyy-MM-dd'T'HH:mm" />
					<fmt:formatDate value="${dateString}" pattern="M월 d일  E'요일' a h시  m분 " />

					<br> ${MeetingVO.mtAddress} ${MeetingVO.mtPlace} <br> ${MeetingVO.mtName} <br> ${MeetingVO.mtSupplies}

					<button class="btn-meeting" data-oper='joinMeeting' value="${MeetingVO.mtNum}">
						<c:choose>
							<c:when test="${MeetingVO.usrMtState eq '참석중'}">만남 참석 취소</c:when>
							<c:when test="${MeetingVO.usrMtState eq '미참석' || MeetingVO.usrMtState==null || MeetingVO.usrMtState eq '모임탈퇴'}">만남 참석</c:when>
						</c:choose>
					</button>


					<c:if test="${usrNum == club.cbLeaderNum}">
						<button class="btn-meeting" data-oper='modifyMeeting' value="${MeetingVO.mtNum}">만남 수정</button>
					</c:if>

				</div>
			</c:forEach>
		</div>


		<div style="float: left; margin-right: 50px; margin-left: 230px; margin-bottom: 30px;">
			<!-- 로그인 유저가 사용자이면 가입하기 버튼을 보여준다 -Sean -->
			<c:if test="${usrNum == club.cbLeaderNum}">
				<button style="padding: 5px 80px;" class="btn-meeting" data-oper='addMeeting'>만남 추가</button>
			</c:if>
		</div>

		<input type="hidden" name="cbNum" value="<c:out value="${club.cbNum}" />" />
		<input type="hidden" name="cbName" value="${club.cbName }" />
	</form>


</div>
<!-- body end -->




<div id="id01" class="modal">
	<span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">×</span>

	<form class="modal-content" action="/regular/clubjoin" method="post">
		<div class="container">
			<h2>가입인사</h2>
			<input type="hidden" name="cbNum" value="<c:out value="${club.cbNum}" />" />
			<input type="hidden" name="usrNum" value="<c:out value="${usrNum}" />" />
			<input type="hidden" name="cbType" value="정기모임" />
			<input type="hidden" name="cbName" value="${club.cbName }" />
			<input type="hidden" name="cbJoinStateResult" value="승인대기" />
			<label><b>가입일자</b></label>
			<input type="text" name="cbAppDate" value="<c:out value="${toDate}"/>" readonly="true">
			<br> <label><b>이름</b></label>
			<input type="text" name="usrName" value="<c:out value="${usrName}"/>" readonly="true">
			<br> <label><b>가입인사</b></label>
			<textarea rows="5" cols="50" style="resize: none" name="cbMemIntro"></textarea>
			<br>
			<div class="clearfix">
				<button type="submit" onclick="document.getElementById('id01').style.display='none'" class="submitbtn">제출하기</button>
			</div>
		</div>
	</form>
</div>



<script type="text/javascript">
	var modal = document.getElementById('id01');
	
	var replyer = false;
	<sec:authorize access="isAuthenticated()">
		/* replyer = '<sec:authentication property="principal.username"/>'; */
		replyer = true;
	</sec:authorize>
	
	/* window.onclick = function(event) {
		if(!replyer){
				alert("로그인");
				location.href="/regular/clubjoin?cbNum=${club.cbNum}";
				return ;
			if(event.target == modal) {
				modal.style.display = "block";
			}
		}
	} */
	
	
	const btnText = $("#join").text().trim();
	console.log(btnText);
	if (btnText=='모임 가입불가'||btnText=='승인 대기 중'||btnText=='모임 정원 초과') {
		document.getElementById("join").disabled = 'disabled';
	} 
	
	
	
	$("button[data-oper='join']").on(
			"click",
			function(e) {
				e.preventDefault();
				
				if ($("#join").text().trim() == '모임 나가기') {
					$(".modal-content").submit();
				}
				
				else if ($("#join").text().trim() == '모임 가입하기') {
					join();
				}																															
			});
	
	
	function join() {
		if(!replyer){
			location.href="/regular/clubjoin?cbNum=${club.cbNum}";
			return;
		} else {
			
			modal.style.display = "block";
		}
	}
	
	
	
	
	// Meeting에 관련된 것들 중에서 -> 참석하기, 개설하기, 수정하기 중 버튼을 누른다면
	let formObj = $("#meeting-form");
		
	$('.btn-meeting').on(
			"click",
			function(e) {
				e.preventDefault();

				let operation = $(this).data("oper");
				console.log(operation);
				
				//만남 참석하기 버튼 눌렀을 때
				if (operation === 'joinMeeting') {
					if ($("button[data-oper='joinMeeting']").text().trim() == '만남참석취소')
						alert('만남 참석취소합니다');
					else if ($("button[data-oper='joinMeeting']").text().trim() == '만남참석')
						alert('만남 참석합니다');
	
					formObj.attr("action","/meeting/join").attr("method", "post");
					formObj.append("<input type='hidden' name='mtNum' value='" + $(this).val() + "'>");
				} 
				// 만남 추가하기 버튼 눌렀을 때
				else if (operation === 'addMeeting') {
					alert('만남 추가합니다');
					formObj.attr("action","/meeting/add");
				}
				// 만남 수정하기 버튼 눌렀을 때
				else if (operation === 'modifyMeeting') {
					alert('만남 수정합니다');
					formObj.attr("action", "/meeting/modify");
					formObj.append("<input type='hidden' name='mtNum' value='" + $(this).val() + "'>");
				}
				formObj.submit();
			});
	
	
	// 사용자의 참석상태(joinState)가 '가입승인'이라면 버튼을 활성화 해주고, 그게 아니라면 버튼을 비활성화한다.
	if ('${joinState}' !== '가입승인') {
		$("button[data-oper='joinMeeting']").attr("disabled", "disabled");
	}
		
	
	
	
</script>
<%@include file="../includes/footer.jsp"%>