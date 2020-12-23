<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%-- <%@include file="../includes/header.jsp" %> --%>
<link rel="stylesheet" href="../resources/css/clubBoardStyle.css">

<div id="bgpic">
	<div id="detail">
         <div id="leftinfo">
         	<img src="../resources/img/mount.jpg" alt="">
			<div id=banner>
				<ul>
					<li><a href="/regular/info?cbNum=<c:out value="${cbNum}" />">정보</a></li> <!--cbNum(모임번호)을 가지고 모임상세페이지이동-->
					<li><a href="/regular/board?cbNum=<c:out value="${cbNum}" />">게시판</a></li> <!--cbNum(모임번호)을 가지고 게시판페이지이동-->
					<li><a href="/regular/chat?cbNum=<c:out value="${cbNum}" />">채팅</a></li>
				</ul>
			</div>
			<div id=bodymain>
			<h2>글쓰기</h2> 
			
			<form name="newadd" role="form" action="/regular/boardadd" method="post" onsubmit="return inputCheck();">
				
				<div class="form-group">
					<label>제목</label><br> 
					<input type="text" class="form-control" name='cbBdTitle' placeholder="제목을 입력해주세요.">
				</div>
				
				<div class="form-group">
					<label>작성자</label><br>
					<input type="text" class="form-control" name='cbBdWriter' placeholder="이름을 입력해주세요.">
				</div>
				
				<div class="form-group">
					<label>내용</label><br>
					<textarea class="form-control" name='cbBdContent' placeholder="내용을 입력해주세요."></textarea>
				</div>
				
				<div id="addbtn">
				<button type="submit" class="btn">등록</button>
				<button type="reset" class="btn">취소</button>
				</div>
				
				<input type="hidden" name="cbNum" value="${cbNum}"/>
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

	//유효성 검사 (빈문자열 체크, 글자 제한(30자이내로), 공백 제한 등)
	function inputCheck(){
		let title = document.newadd.cbBdTitle;
		
		if(!title.value || title.value.length > 30) {
			alert("제목을 입력해주세요.");
			return false;
		}
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
<%-- <%@include file="../includes/footer.jsp" %> --%>