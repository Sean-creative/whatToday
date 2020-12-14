<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" href="../resources/css/clubBoardStyle.css">

<div id="body">
	<div id="banner">
		<ul>
			<li><a href="/regular/info?cbNum=<c:out value="${cbNum}" />">정보</a></li> <!--cbNum(모임번호)을 가지고 모임상세페이지이동-->
			<li><a href="/regular/board?cbNum=<c:out value="${cbNum}" />">게시판</a></li> <!--cbNum(모임번호)을 가지고 게시판페이지이동-->
			<li><a href="javascript:void(0);" onClick="alert('곧 오픈됩니다!'); return false;">채팅</a></li> <!--a태그의 페이지이동 기능 무효화 및 클릭시 경고창 -->
		</ul>
	</div>
	<div id="bodymain">
				
		<form id="formBoardUpdate" role="form" action="/regular/boardupdate" method="post">
				
			<div class="form-group">
				<label>게시판 번호</label> 
				<input class="form-control" name='cbBno' value = '<c:out value="${club.cbBno}"/>' readonly="readonly"/>
			</div>
			
			<div class="form-group">
				<label>제목</label> 
				<input class="form-control" name='cbBdTitle' value = '<c:out value="${club.cbBdTitle}"/>'/>
			</div>
			
			<div class="form-group">
				<label>내용</label>
				<textarea class="form-control" rows="5" name='cbBdContent'>
					<c:out value="${club.cbBdContent}"/>
				</textarea>
			</div>
			
			<div class="form-group">
				<label>작성자</label>
				<input class="form-control" name='cbBdWriter' value = '<c:out value="${club.cbBdWriter}"/>' readonly="readonly"/>
			</div>
			
			<button type="submit" data-oper='update' class="btn btn-default">수정</button>
			<button type="submit" data-oper='delete' class="btn btn-danger">삭제</button>
			<button type="submit" data-oper="list" class="btn btn-info">목록으로 이동</button>
			
			<input type="hidden" id="cbNum" name="cbNum" value='<c:out value="${cbNum}" />'/>
		</form>
			
	</div>
</div>	

<script type="text/javascript">
	$(document).ready(function() {
		
		var formObj = $("#formBoardUpdate");
		$('button').on("click", function(e) {
			e.preventDefault();
			var operation = $(this).data("oper");
			
			console.log(operation);
			
			if (operation === 'delete') {
				formObj.attr("action", "/regular/boarddelete");
			} else if (operation === 'list') {
				formObj.attr("action", "/regular/board?cbNum="+$("#cbNum")).attr("method", "get");
			}
			formObj.submit();
		});
	});
</script>

<%@include file="../includes/footer.jsp" %>