<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" href="../resources/css/clubBoardStyle.css">

<div id="regularBoard">
	<div id="detail">
         <div id="leftinfo">
         	<div>
            	<p id="topInfo">#${club.cbSubcat} #${club.cbDistrict}</p>
            </div>
            <div>
            	<p id="topcbName">${club.cbIntro}, ${club.cbName}</p>         
            </div>
         	<img src="${cbThumbImg}" alt="">
			<div id=banner>
				<ul>
					<li><a href="/regular/info?cbNum=<c:out value="${cbNum}" />">정보</a></li> <!--cbNum(모임번호)을 가지고 모임상세페이지이동-->
					<li><a href="javascript:void(0);">게시판</a></li> <!--a태그의 페이지이동 기능 무효화 -->
					<li><a href="/regular/chat?cbNum=<c:out value="${cbNum}" />">채팅</a></li>
				</ul>
			</div>
			<div id=bodymain>
			<h2>조회</h2>
			 	
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
					<textarea class="form-control" name='cbBdContent' readonly="readonly">
						<c:out value="${club.cbBdContent}"/></textarea>
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
					        <input type="text" name="reply" id="reply" class="form-control" placeholder="댓글을 입력해주세요.">
				        </div>
				        <div class="col-sm-2">
					        <input name="replyer" class="form-control" id="replyer" placeholder="댓글 작성자"></input>
					        <button type="button" class="btn btn-sm btn-promary" id="btnReplyInsert">등록</button>
				        </div>	
			        </div> 
		        </form>
	            </div> <!--END 댓글 등록-->
	
	            <!-- 댓글 목록  -->	
	            <div class="my-3 p-3 bg-white rounded shadow-sm">
		            <div id="replyList"></div>
	            </div>
		
			<div class='pullright'>
				<ul class="pagination">
						
						<c:if test = "${pageMaker.prev }">
							<li class="paginate_button previous"><a href="${pageMaker.startPage -1}">Previous</a></li>
						</c:if>
						
						<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage}">
							<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active":""}"><a href="${num}">${num}</a></li>
						</c:forEach>	
						
						<c:if test="${pageMaker.next }">
							<li class="paginate_button next"><a href="${pageMaker.endPage +1}">Next</a></li>
						</c:if>						
					</ul>
			</div><!-- END pullright -->
			</div><!-- END bodymain --> 
		</div><!-- END leftInfo -->
<div id="rightinfo" class="rightinfo">
            <div class="contentup">
                <div class="contentl">
                   <p>만남 일정</p>
                </div>
                <div class="contentr">
               <!-- 로그인 유저가 모임장이면 만남 추가 버튼을 보여준다 -->
               <c:if test="${usrNum == club.cbLeaderNum}">
                  <button class="btn-meeting" data-oper='addMeeting'>만남 추가</button>
               </c:if>
            </div>
                </div>
                <div style="margin: 0 10px">
                <div class="contentmid">
                   
                  <form action="#" method="get" id="meeting-form">
               <%-- <c:choose>
                        <c:when test="${ClubMemberVO.usrNum == clubVO.cbLeaderNum}">모임장</c:when>
                        <c:otherwise>모임원</c:otherwise>
               </c:choose> --%>
               <c:forEach items="${meetingList}" var="MeetingVO">
                     <p id = "meetingName">🔸 ${MeetingVO.mtName} (${MeetingVO.mtCurMbNum}/${MeetingVO.mtMbNum}명)</p>
			               <button class="btn-meeting" data-oper='joinMeeting' value="${MeetingVO.mtNum}">
			                  <c:choose>
			                     <c:when test="${MeetingVO.usrMtState eq '참석중'}">참석 취소</c:when>
			                     <c:when test="${MeetingVO.usrMtState eq '미참석' || MeetingVO.usrMtState==null || MeetingVO.usrMtState eq '모임탈퇴'}">참석</c:when>
			                  </c:choose>
			               </button>
                     
                     <fmt:parseDate var="dateString" value="${MeetingVO.mtStartDate}" pattern="yyyy-MM-dd'T'HH:mm" />
                     <p>🔸 <fmt:formatDate value="${dateString}" pattern="M월 d일  E'요일' a h시  m분 " /></p>
                     
                    <p>🔸 ${MeetingVO.mtAddress} ${MeetingVO.mtPlace}</p>
                     
                     <p>🔸 ${MeetingVO.mtSupplies}</p>
               
               <hr width="100%" style="margin: 10px">
         
               </c:forEach>
               <input type="hidden" name="cbNum" value="<c:out value="${club.cbNum}" />" />
               <input type="hidden" name="cbName" value="${club.cbName }" />
               </form>
                </div>      
                </div>      
        </div> <!-- rightinfo END -->
        </div><!-- END detail -->
    </div><!-- END regularBoard -->
			<!--  end Pagination --> 
		    <form id='actionForm' action="/regular/board" method='get'>
		    	<input type="hidden" id="cbNum" name="cbNum" value="<c:out value="${cbNum}" />"/>
				<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'>
				<input type='hidden' name='amount' value='${pageMaker.cri.amount }'>
			</form>		
 
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