<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" href="../resources/css/clubBoardStyle.css">

<div id="bgpic">
	<div id="detail">
         <div id="leftinfo">
         	<img src="${cbThumbImg}" alt="">
			<div id=banner>
				<ul>
					<li><a href="/regular/info?cbNum=<c:out value="${cbNum}" />">정보</a></li> <!--cbNum(모임번호)을 가지고 모임상세페이지이동-->
					<li><a href="/regular/board?cbNum=<c:out value="${cbNum}" />">게시판</a></li> <!--cbNum(모임번호)을 가지고 게시판페이지이동-->
					<li><a href="/regular/chat?cbNum=<c:out value="${cbNum}" />">채팅</a></li>
				</ul>
			</div>
			<div id=bodymain>
			<span class="half">글 조회</span>
			 	
			 	<div class="rowget">
				<div class="form-group">
					<label>게시판 번호</label><br> 
					<input type="text"class="form-control" name='cbBno' value = '<c:out value="${club.cbBno}"/>' readonly="readonly">
				</div>
				
				<div class="form-group">
					<label>제목</label><br> 
					<input type="text"class="form-control" name='cbBdTitle' value = '<c:out value="${club.cbBdTitle}"/>' readonly="readonly">
				</div>
				
				<div class="form-group">
					<label>작성자</label><br>
					<input type="text" class="form-control" name='cbBdWriter' value = '<c:out value="${club.cbBdWriter}"/>' readonly="readonly">
				</div>
				
				<div class="form-group">
					<label>내용</label><br>
					<textarea class="form-control" name='cbBdContent' readonly="readonly"><c:out value="${club.cbBdContent}"/></textarea>
				</div>
				
				<button data-oper='update' class="btn">수정</button>
				<button data-oper='list' class="btn">목록</button>
				
				</div>
				<form id='operForm' action="/regular/boardupdate" method="get">
					<input type='hidden' id='cbBno' name='cbBno' value='<c:out value="${club.cbBno}"/>'/>
					<input type="hidden" id="cbNum" name="cbNum" value="<c:out value="${cbNum}" />"/>
					<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'/>
					<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'/>
				</form>		
				<hr>
				
	<!-- 댓글 등록  -->
 	<div class="my-3 p-3 bg-white rounded shadow-sm">
		<form name="form" id="form" role="form" modelAttribute="replyVO" method="post">
		<form:hidden path="cbBno" id="cbBno"/>
			<div class="row">
				<div class="col-sm-10">
					<input type="text" name="reply" id="reply" class="form-control" placeholder="댓글을 입력해주세요." style="width:614px;"/>
					<button type="button" class="btn btn-sm btn-promary" id="btnReplyInsert">등록</button>
				</div>	
			</div>
		</form>
	</div>  
	
	<!-- 댓글 목록  -->	
	<div class="my-3 p-3 bg-white rounded shadow-sm">
		<div id="replyList" style="margin-left: 25px;"></div>
	</div>
	
		</div>
	</div>	
	
		<div id="rightinfo" class="rightinfo">
                <div class="content">
					<c:out value="${cbName}" />
                </div>
        </div>
	</div>
 </div>
 
<script src="http://code.jquery.com/jquery-latest.js"></script>
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
					htmls += '<span style="padding-left:25px">등록된 댓글이 없습니다.</span>';
				} else {
					$(result).each(function(){
		            	htmls += '<div class="media text-muted pt-3" id="rno' + this.rno + '" style="padding: 5px 0 5px 0;">';
		                htmls += '<title>Placeholder</title>';
		                htmls += '<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">';
		                htmls += '<div>';
		                htmls += '<span class="d-block">';
		                htmls += '<strong class="text-gray-dark">' + this.replyer + '</strong>';
		                htmls += '<span style="padding-left: 7px; font-size: 9pt">';
		                if (this.isReplyer == "true") {
			                htmls += '<a href="javascript:void(0)" onclick="fn_editReply(' + this.rno + ', \'' + this.replyer + '\', \'' + this.reply + '\' )" style="padding-right:5px">수정</a>';
			                htmls += '<a href="javascript:void(0)" onclick="fn_deleteReply(' + this.rno + ')" >삭제</a>';
		                }
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
			, type : 'GET'
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
		/* htmls += '<input type="text" name="editContent" id="editContent" class="form-control">';
		htmls += reply;
		htmls += '</>'; */
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
<script>
window.onscroll = function() {myFunction()};

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
<%@include file="../includes/footer.jsp" %>