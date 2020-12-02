<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" href="../resources/css/clubBoardStyle.css">

<div id="body">
	<div id=banner>
		<ul>
			<li><a href="/regular/info?cbNum=<c:out value="${cbNum}" />">정보</a></li> <!--cbNum(모임번호)을 가지고 모임상세페이지이동-->
			<li><a href="/regular/board?cbNum=<c:out value="${cbNum}" />">게시판</a></li> <!--cbNum(모임번호)을 가지고 게시판페이지이동-->
			<li><a href="javascript:void(0);" onClick="alert('곧 오픈됩니다!'); return false;">채팅</a></li> <!--a태그의 페이지이동 기능 무효화 및 클릭시 경고창 -->
		</ul>
	</div><div id=bodymain>
			
			<form role="form" action="/regular/boardadd" method="post">
				<div class="form-group">
					<label>제목</label> <input class="form-control" name='cbBdTitle'>
				</div>
				
				<div class="form-group">
					<label>내용</label>
					<textarea class="form-control" rows="5" name='cbBdContent'></textarea>
				</div>
				
				<div class="form-group">
					<label>작성자</label>
					<input class="form-control" name='cbBdWriter'>
				</div>
				
				<button type="submit" class="btn btn-default">등록</button>
				<button type="button" class="btn btn-default">취소</button>
				
				<input type="hidden" name="cbNum" value="${cbNum}"/>
			</form>
			
			</div>
</div>	
</body>

<%@include file="../includes/footer.jsp" %>