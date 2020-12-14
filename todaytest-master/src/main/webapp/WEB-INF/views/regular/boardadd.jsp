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
			
			<form name="newadd" role="form" action="/regular/boardadd" method="post" onsubmit="return inputCheck();">
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

<script type="text/javascript">

	//유효성 검사 (빈문자열 체크, 글자 제한(30자이내로), 공백 제한 등)
	function inputCheck(){
		let title = document.newadd.cbBdTitle;
		
		if(!title.value || title.value.length > 30) {
			alert("제목을 입력해주세요.");
			return false;
		}
	}
</script>		
<%@include file="../includes/footer.jsp" %>