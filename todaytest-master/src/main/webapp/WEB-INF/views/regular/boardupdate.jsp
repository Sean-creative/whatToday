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
		 <h2>수정</h2> 
		 		
		 <form id="formBoardUpdate" role="form" action="/regular/boardupdate" method="post">
			
			<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'/>
			<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'/>
			<input type="hidden" id="cbNum" name="cbNum" value='<c:out value="${cbNum}" />'/>
			
			<div class="form-group">
				<label>게시판 번호</label><br>
				<input type="text" class="form-control" name='cbBno' value = '<c:out value="${club.cbBno}"/>' readonly="readonly"/>
			</div>
			
			<div class="form-group">
				<label>제목</label><br> 
				<input type="text" class="form-control" name='cbBdTitle' value = '<c:out value="${club.cbBdTitle}"/>'/>
			</div>
			
			<div class="form-group">
				<label>작성자</label><br>
				<input type="text" class="form-control" name='cbBdWriter' value = '<c:out value="${club.cbBdWriter}"/>' readonly="readonly"/>
			</div>
			
			<div class="form-group">
				<label>내용</label><br>
				<textarea class="form-control" name='cbBdContent'>
					<c:out value="${club.cbBdContent}"/>
				</textarea>
			</div>
			
			<button type="submit" data-oper='update' class="btn btn">수정</button>
			<button type="submit" data-oper='delete' class="btn btn">삭제</button>
			<button type="submit" data-oper="list" class="btn btn">목록</button>
			
		</form>
			
		</div>
		</div>	
	
		<div id="rightinfo" class="rightinfo">
                <div class="content">
					<c:out value="${cbName}" />
                </div>
        </div>
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
				
				formObj.attr("action", "/regular/board").attr("method", "get");
				var cbNumTag = $("input[name='cbNum']").clone();
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				
				formObj.empty();
				formObj.append(cbNumTag);
				formObj.append(pageNumTag);
				formObj.append(amountTag);
			}
			formObj.submit();
		});
	});
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