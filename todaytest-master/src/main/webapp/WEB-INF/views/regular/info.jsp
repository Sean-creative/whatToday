<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri = "http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" href="../resources/css/clubInfoStyle.css">

	<div id="banner">
		<ul>
			<li><a href="javascript:void(0);">정보</a></li>  <!--a태그의 페이지이동 기능 무효화 -->
			<li><a href="/regular/board?cbNum=<c:out value="${club.cbNum}" />">게시판</a></li> <!--cbNum(모임번호)을 가지고 게시판페이지이동-->
			<li><a href="javascript:void(0);" onClick="alert('곧 오픈됩니다!'); return false;">채팅</a></li> <!--a태그의 페이지이동 기능 무효화 및 클릭시 경고창 -->
		</ul>
	</div>

	<div id="body">
		<div id=up>해시태그 - <c:out value="${club.cbHashtag}" /></div>
    	<div id=mid>[모임명]<c:out value="${club.cbName}" /></div>
    	<div id=dow><img src="/resources/img/clubsample.jpg" alt='sample' align="left">
    		한줄소개 - <c:out value="${club.cbIntro}" /><br>
    		상세내용 - <c:out value="${club.cbDetailContent}" /></div>
    	<div>개설자 - <c:out value="${club.cbLeaderName }"/></div>	
    	<!-- <button type="submit" onclick="document.getElementById('id01').style.display='none'">가입하기</button> -->
    	<!-- <button onclick="javascript:join();">가입하기</button> -->
    	
    	<!-- 로그인 유저의 정보와 개설자의 번호가 일치하지 않으면 버튼을 보여줘야한다. -->
	<c:if test="${usrNum != club.cbLeaderNum}">
	<button style="margin-left: 230px; padding: 5px 80px; margin-bottom: 30px;" class="btn btn-info" 
	data-oper='join' id="join">		
		<!-- joinState - 모임추방, 모임만료, 모임탈퇴, 가입승인, Null (아직 데이터 넣기 전) -->
		<c:choose>
		<c:when test="${joinState eq '가입승인'}">모임 나가기</c:when>
		<c:when test="${joinState eq '승인대기'}">승인 대기 중</c:when>
		<c:when test="${joinState eq '모임탈퇴' || joinState == null}">모임 가입하기</c:when>
		<c:otherwise>가입불가</c:otherwise>
		</c:choose>
	</button>
</c:if>	
</div>
	<div id="id01" class="modal">
		<span onclick="document.getElementById('id01').style.display='none'"
			class="close" title="Close Modal">×</span>

		<form class="modal-content" action="/regular/clubjoin" method="post">
			<div class="container">
				<h2>가입인사</h2>
				<input type="hidden" name="cbNum" value="<c:out value="${club.cbNum}" />"/>
				<input type="hidden" name="usrNum" value="<c:out value="${usrNum}" />"/>
				<input type="hidden" name="cbType" value="정기모임"/>
				<input type="hidden" name="cbName" value="${club.cbName }"/>
				<input type="hidden" name="cbJoinStateResult" value="승인대기"/> 
				<label><b>가입일자</b></label> 
				<input type="text" name="cbAppDate" value="<c:out value="${toDate}"/>" readonly="true"><br>
				<label><b>이름</b></label>
				<input type="text" name="usrName" value="<c:out value="${usrName}"/>" readonly="true"><br>
				<label><b>가입인사</b></label> 
				<textarea rows="5" cols="50" style="resize: none" name="cbMemIntro"></textarea><br>
			<div class="clearfix">
				<button type="submit" onclick="document.getElementById('id01').style.display='none'"
				class="submitbtn">제출하기</button>
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
	
	function join() {
		if(!replyer){
			location.href="/regular/clubjoin?cbNum=${club.cbNum}";
			return;
		} else {
			
			modal.style.display = "block";
		}
	}
	
	console.log($("#join").text().trim());
	if ($("#join").text().trim() == '가입불가' || $("#join").text().trim() == '승인 대기 중') {
		document.getElementById("join").disabled = 'disabled';
	}
	
</script>
<%@include file="../includes/footer.jsp" %>