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
				
				<div class="row">
				<div class="col-lg-12">
				<div class="panel panel-default">
				
				<div class="form-group">
					<label>게시판 번호</label> <input class="form-control" name='cbBno'
					 value = '<c:out value="${club.cbBno}"/>' readonly="readonly">
				</div>
				
				<div class="form-group">
					<label>제목</label> <input class="form-control" name='cbBdTitle'
					 value = '<c:out value="${club.cbBdTitle}"/>' readonly="readonly">
				</div>
				
				<div class="form-group">
					<label>내용</label>
					<textarea class="form-control" rows="5" name='cbBdContent' 
					readonly="readonly"><c:out value="${club.cbBdContent}"/></textarea>
				</div>
				
				<div class="form-group">
					<label>작성자</label>
					<input class="form-control" name='cbBdWriter'
					 value = '<c:out value="${club.cbBdWriter}"/>' readonly="readonly">
				</div>
				
				<button data-oper='update' class="btn btn-default">수정</button>
				<button data-oper='list' class="btn btn-info">목록으로 이동</button>
				
				<form id='operForm' action="/regular/boardupdate" method="get">
					<input type='hidden' id='cbBno' name='cbBno' value='<c:out value="${club.cbBno}"/>'>
					<input type="hidden" id="cbNum" name="cbNum" value="<c:out value="${cbNum}" />"/>
				</form>
				
				</div>
				</div>
				</div>
		</div>

<!-- 댓글목록 처리 -->
		<div class='row'>
			<div class="col-lg-12">
				<div class="panel panel-default">
					 <div class="panel-heading">
        				<i class="fa fa-comments fa-fw"></i> Reply
      				 </div> 
					<div class="panel-body">
						<ul class="chat">
						</ul>
					</div>
					<div class="panel-footer"></div>
				</div>
			</div>
		</div>	
</div>

<script type="text/javascript" src="/resources/js/reply.js"></script>
<script type="text/javascript">

	$(document).ready(function() {

				var operForm = $("#operForm");

				$("button[data-oper='update']").on("click", function(e) {

					operForm.attr("action", "/regular/boardupdate").submit();

				});

				$("button[data-oper='list']").on("click",function(e) {
							console.log($("#cbNum").val())
							operForm.find("#cbBno").remove();
							operForm.attr("action", '/regular/board?cbNum='+ $("#cbNum").val());
							operForm.submit();
						});
			});
</script>
<script>
	//댓글
/* 	console.log(replyService);
	console.log("==============");
	console.log("JS TEST");
	
	var cbBnoValue = '<c:out value="${club.cbBno}"/>';
	var cbNumValue = '<c:out value="${cbNum}"/>';
	
	//for replyService add test
 	replyService.add(
			{reply: "JS Test", replyer:"tester", cbBno:cbBnoValue, cbNum:cbNumValue},
			function(result){
				alert("RESULT: " + result);
			}
	); 
	
	replyService.getList({cbBno:cbBnoValue}, function(list) {
		
	
		for(var i = 0, len=list.length || 0; i< len; i++) {
			
			console.log(list[i]);
		}
	});
	
 	replyService.remove(15, function(count) {
		
		console.log(count);
		
		if(count === "success") {
			alert("REMOVED");
		}
	}, function(err) {
		alert('ERROR...');
	}); 
	
	replyService.update({
		rno : 22,
		cbBno : cbBnoValue,
		reply : "Modified Reply...."
	}, function(result) {
		alert("수정 완료....");
	});
	
	replyService.get(22, function(data) {
		console.log(data);
	});  */
</script>

<script>  
	$(document).ready(function() {

						var cbBnoValue = '<c:out value="${club.cbBno}"/>';
						var cbNumValue = '<c:out value="${cbNum}"/>';
						var replyUL = $(".chat");

						showList(1);

						function showList(page) {

							replyService.getList({cbBno : cbBnoValue}, function(list) {

												var str = "";
												if (list == null || list.length == 0) {
													replyUL.html("");
													return;
												}
												for (var i = 0, len = list.length || 0; i < len; i++) {
												       str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
												       str +="  <div><div class='header'><strong class='primary-font'>["
												    	   +list[i].rno+"] "+list[i].replyer+"</strong>"; 
												       str +="    <small class='pull-right text-muted'>"
												           +replyService.displayTime(list[i].replyDate)+"</small></div>";
												       str +="    <p>"+list[i].reply+"</p></div></li>";
												     }
												     
												     replyUL.html(str);
											});
						}

				});
					 
</script>

<%@include file="../includes/footer.jsp" %>