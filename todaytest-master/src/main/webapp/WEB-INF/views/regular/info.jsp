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
    	<button type="submit" onclick="document.getElementById('id01').style.display='block'">가입하기</button>
</div>
	<div id="id01" class="modal">
		<span onclick="document.getElementById('id01').style.display='none'"
			class="close" title="Close Modal">×</span>

		<form class="modal-content" action="/regular/clubjoin" method="post">
			<div class="container">
				<h2>가입인사</h2>
				<input type="hidden" name="cbNum" value="<c:out value="${club.cbNum}" />"/>
				<input type="hidden" name="usrNum" value="<c:out value="${userVO.usrNum}" />"/>
				<input type="hidden" name="cbType" value="정기모임"/>
				<input type="hidden" name="cbName" value="${club.cbName }"/>
				<input type="hidden" name="cbJoinStateResult" value="승인대기"/> 
				<label><b>가입일자</b></label> 
				<input type="text" name="cbAppDate"><br>
				<label><b>이름</b></label>
				<input type="text" name="usrName" value="<c:out value="${userVO.usrName}" />"><br>
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
	
	var replyer = null;
	<sec:authorize access="isAuthenticated()">
		replyer = '<sec:authentication property="principal.username"/>';
	</sec:authorize>
	
	window.onclick = function(event) {
		if(!replyer){
				alert("로그인");
				location.href="/regular/clubjoin?cbNum=${club.cbNum}";
				return ;
			if(event.target == modal) {
				modal.style.display = "block";
			}
		}
	}
	
</script>
<%@include file="../includes/footer.jsp" %>