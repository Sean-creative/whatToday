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
		
<!-- 댓글 등록  -->
<div>
 	<!-- <div class="my reply add"> -->
 	<div class="my-3 p-3 bg-white rounded shadow-sm" style="padding-top: 10px">
		<form name="form" id="form" role="form" modelAttribute="replyVO" method="post">
		<form:hidden path="cbBno" id="cbBno"/>
			<div class="row">
				<div class="col-sm-10">
					<textarea name="reply" id="reply" class="form-control" cols="100" rows="3" style="resize: none;" placeholder="댓글을 입력해주세요."></textarea>
				</div>
				<div class="col-sm-2">
					<input name="replyer" class="form-control" id="replyer" placeholder="댓글 작성자"></input>
					<button type="button" class="btn btn-sm btn-promary" id="btnReplyInsert" style="width: 30%; margin-top: 10px">등록</button>
				</div>	
			</div>
		</form>
	</div>  
	
<!-- 댓글 목록  -->	
	<div class="my-3 p-3 bg-white rounded shadow-sm" style="padding-top: 10px">
				<div id="replyList"></div>
	</div>
</div>	

<!-- 댓글목록 처리 -->
<!-- 		<div class='row'>
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body">
						<ul class="chat">
						</ul>
					</div>
					<div class="panel-footer"></div>
				</div>
			</div>
		</div>
</div> -->
</div>
<!-- <script type="text/javascript" src="/resources/js/reply.js"></script> -->
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

<!-- <script>  
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
					 
</script> -->

<script>

	<c:url var="btnReplyInsert" value="/replies/insert"></c:url>
	<c:url var="updateReplyURL" value="/replies/update"></c:url>
	<c:url var="deleteReplyURL" value="/replies/delete"></c:url>

	$(document).ready(function() {
		showReplyList();
	});
	
	function showReplyList() {
		
		var url = "${pageContext.request.contextPath}/replies/list";
		var paramData = {"cbBno": "${club.cbBno}"};
		$.ajax({
            type: 'POST',
            url: url,
            data: paramData,
            dataType: 'json',
            success: function(result) {
               	var htmls = "";
				if(result.length < 1){
					console.log("result.length:"+result.length);
					htmls += "<span>등록된 댓글이 없습니다.</span>";
				} else {
					$(result).each(function(){
		            	htmls += '<div class="media text-muted pt-3" id="rno' + this.rno + '" style="padding: 5px 0 5px 0;">';
		                htmls += '<title>Placeholder</title>';
		                htmls += '<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">';
		                htmls += '<div>';
		                htmls += '<span class="d-block">';
		                htmls += '<strong class="text-gray-dark">' + this.replyer + '</strong>';
		                htmls += '<span style="padding-left: 7px; font-size: 9pt">';
		                htmls += '<a href="javascript:void(0)" onclick="fn_editReply(' + this.rno + ', \'' + this.replyer + '\', \'' + this.reply + '\' )" style="padding-right:5px">수정</a>';
		                htmls += '<a href="javascript:void(0)" onclick="fn_deleteReply(' + this.rno + ')" >삭제</a>';
		                htmls += '</span>';
		                htmls += '</span>';
		                htmls += '</div>';
		                htmls += '<div>';
		                htmls += this.reply;
		                htmls += '</div>';
		                htmls += '</p>';
		                htmls += '</div>';
		           });	//each end
				}
				$("#replyList").html(htmls);
            }	   // Ajax success end
		});	// Ajax end
	}

	$(document).on('click', '#btnReplyInsert', function() {
		
		var reply = $('#reply').val();
		var replyer = $('#replyer').val();
		var paramData = JSON.stringify({"reply":reply, "replyer":replyer, "cbBno":"${club.cbBno}", "cbNum":"${cbNum}"});
	    var headers = {"Content-Type" : "application/json", "X-HTTP-Method-Override" : "POST"};
		
	    $.ajax({

			url: "${btnReplyInsert}"
			, headers : headers
			, data : paramData
			, type : 'POST'
			, dataType : 'text'
			, success: function(result){
				showReplyList();
				$('#reply').val('');
				$('#replyer').val('');
			}
			, error: function(error){
				console.log("에러 : " + error);
			}
		});
	});
	
	function fn_editReply(rno, replyer, reply){

		var htmls = "";
		htmls += '<div class="media text-muted pt-3" id="rno' + this.rno + '" style="padding: 5px 0 5px 0;">';
		htmls += '<title>Placeholder</title>';
		htmls += '<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">';
		htmls += '<div>';
		htmls += '<span class="d-block">';
		htmls += '<strong class="text-gray-dark">' + replyer + '</strong>';
		htmls += '<span style="padding-left: 7px; font-size: 9pt">';
		htmls += '<a href="javascript:void(0)" onclick="fn_updateReply(' + rno + ', \'' + replyer + '\')" style="padding-right:5px">저장</a>';
		htmls += '<a href="javascript:void(0)" onClick="showReplyList()">취소<a>';
		htmls += '</span>';
		htmls += '</span>';		
		htmls += '</div>';		
		htmls += '<div>';		
		htmls += '<textarea name="editContent" id="editContent" class="form-control" cols="100" rows="3" style="resize: none;">';
		htmls += reply;
		htmls += '</textarea>';
		htmls += '</p>';
		htmls += '</div>';
		htmls += '</div>';
		$('#rno' + rno).replaceWith(htmls);
		$('#rno' + rno + ' #editContent').focus();
	}
	
	function fn_updateReply(rno, replyer){

		var replyEditContent = $('#editContent').val();
		var paramData = JSON.stringify({"reply": replyEditContent, "rno": rno});
		var headers = {"Content-Type" : "application/json", "X-HTTP-Method-Override" : "POST"};

		$.ajax({

			url: "${updateReplyURL}"
			, headers : headers
			, data : paramData
			, type : 'POST'
			, dataType : 'text'
			, success: function(result){
                console.log(result);
				showReplyList();
			}
			, error: function(error){
				console.log("에러 : " + error);
			}
		});
	}
	
	function fn_deleteReply(rno){

		var paramData = {"rno": rno};

		$.ajax({

			url: "${deleteReplyURL}"
			, data : paramData
			, type : 'POST'
			, dataType : 'text'
			, success: function(result){
				showReplyList();
			}
			, error: function(error){
				console.log("에러 : " + error);
			}
		});
		location.reload();
	}
	
</script>

<%@include file="../includes/footer.jsp" %>