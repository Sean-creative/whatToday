
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!-- 작성자 : 김선우 -->

<%@include file="../includes/header.jsp"%>



<link rel="stylesheet" type="text/css" href="/resources/css/thunderList.css">
<style>
* {
	margin: 0;
	padding: 0;
}

#detsrc {
	width: 1200px;
	height: 200px;
	background: #eee;
	margin: 0 auto;
}

.src {
	width: 1100px;
	height: 150px;
	margin: 0 auto;
	display: flex;
	flex-wrap: wrap;
	box-sizing: border-box;
	padding: 0 10px;
}

.dtlfont {
	width: 1200px;
	font-size: 18px;
	margin: 30px 0 15px 5px;
}

.src select {
	width: 220px;
	height: 35px;
	border-radius: 20px;
	padding: 0 15px 0 15px;
	margin-right: 30px;
	margin-top: 0px;
	border: none;
}

.src input[type=text] {
	width: 200px;
	height: 35px;
	border-radius: 20px;
	border: none;
	margin-top: 10px;
	position: relative;
	text-indent: 15px;		
    background-color: white;    
    margin-top: 15px;
	padding-right: 40px;
}

.src ::placeholder {
	color: #333;
}

.btnkeyword {
    width: 40px;
    height: 32px;
    border-radius: 20px;
    border: none;
    background: #fff;
    color: #333;    
    margin-left: 13px;
    transition: 0.5s;
    position: relative;
    z-index: 5;
    left: -55px;
    margin-top: 16px;
}


.btnkeyword:hover {
	background: #ddd;
}

select#searchBy {
	margin-right: 15px;
	margin-top: 15px;
}

button>img {
	width: 17px;
}
</style>




<section id="wrap">

	<form action="/thunder/list" method="get" onsubmit="return inputCheck()">



		<!-- 상세검색창 -->
		<div id="detsrc">
			<div class="src">
				<!-- 		<div id="search">
			<div id="searchform"> -->

				<span class="dtlfont">상세검색</span>
				<!-- name은 ThunderVO가 아닌, Criteria의 변수명으로 맞춰줘야한다. -->
				<select name='category' id='category'></select>

				<select name='subclass' id='subcat'></select>

				<select name='city' id='city'></select>

				<select name='district' id='district'></select>




				<select name='searchBy' id='searchBy' style="width: 130px; height: 35px;">
					<option value='모임명'>모임명</option>
					<option value='글작성자'>글작성자</option>
					<option value='해시태그'>해시태그</option>
					<option value='모임종류'>모임종류</option>
				</select>

				<div style="display: flex;">
					
						<input type='text' id='keyword' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>' placeholder="취미를 찾아보세요!" />
						<button class="btnkeyword" >
							<img src="/resources/img/search.png" alt="">
						</button>									
				</div>

			</div>
		</div>



		<input type="hidden" name="userLatitude" value='<c:out value="${pageMaker.cri.userLatitude}"/>'>
		<input type="hidden" name="userLongitude" value='<c:out value="${pageMaker.cri.userLongitude}"/>'>
	</form>





	<div class="header_in3">
		<ul class="header_weekday">
		</ul>
	</div>


		
		
	<div id="sort">
		<ul>
			<span class="half">번개모임</span>
			<li class="order_button ${pageMaker.cri.orderBy eq 'cbNum desc'? "active":""}" ><a href="cbNum desc">최신순</a></li>
			<li class="order_button ${pageMaker.cri.orderBy eq 'cbView desc'? "active":""}" ><a href="cbView desc">인기순</a></li>
			<li class="order_button ${pageMaker.cri.orderBy eq 'cbAppperiod'? "active":""}" ><a href="cbAppperiod">마감임박순</a></li>
			<li class="order_button ${pageMaker.cri.orderBy eq 'distance'? "active":""}"><a href="distance">거리순</a></li>
		</ul>
	</div>



	<!-- 검색결과 
	<div id="searchresult">
		<c:forEach items="${list}" var="thunderItem" varStatus="status">
			<div class='move' onclick='linkToInfo(${thunderItem.cbNum})' id='itemDiv${status.count}'>

				<img src="${thunderItem.cbThumbImg}" alt="">
				<p class="location"><c:out value="${thunderItem.cbDistrict}" /></p>
				<p class="nombre"><c:out value="${thunderItem.cbName}" /></p>
				<hr style="color: #eee;">
				
				<fmt:parseDate var="dateString" value="${thunderItem.thunderDetailVO.cbDate}" pattern="yyyy-MM-dd'T'HH:mm" />
				<p class="limitmem"><fmt:formatDate value="${dateString}" pattern="M월 d일  E'요일' a h시  m분" /></p>
				
				<p class="limitmem">모집인원 : <c:out value="${thunderItem.cbCurMbnum}" /> / <c:out value="${thunderItem.cbMbnum}" />
			</div>
		</c:forEach>
	</div>-->

		<!-- UI 변경(지영)  -->
		<div id="searchresult">
		   <c:forEach items="${list}" var="thunderItem" varStatus="status">
		      <div class='move' onclick='linkToInfo(${thunderItem.cbNum})' id='itemDiv${status.count}'>
		         <a href='/thunder/info?cbNum=<c:out value="${thunderItem.cbNum}" />'>
		            <img src="${thunderItem.cbThumbImg}" alt="">
		            
		            <p class="topinfo">#${thunderItem.cbCategory} #${thunderItem.cbSubcat} #${thunderItem.cbDistrict}</p>
		            <p class="cbName">${thunderItem.cbName}</p>
					
					<c:set var="today" value="<%=new java.util.Date()%>" />
					<fmt:formatDate var="today" value="${today}" pattern="yyyyMMdd"/>
					<fmt:parseDate var="meetDay" value='${thunderItem.thunderDetailVO.cbDate}' pattern="yyyy-MM-dd'T'HH:mm" />
					<fmt:formatDate var="meetDay" value="${meetDay}" pattern="yyyyMMdd"/>
					
					<c:set var="cbMbNum" value = "${thunderItem.cbMbnum}" />
					<c:set var="cbCurMbNum" value = "${hunderItem.cbCurMbnum}" />
					
					<p class="count">${thunderItem.cbView}명이 보고있습니다.</p>
					
					<span class="meetDday">D-<c:out value="${meetDay-today}"/></span>
		       		<span class="meetDday"><c:out value="${cbMbNum-cbCurMbNum}" />명</span>
		       		<br>
					
					<!--  
		            <fmt:parseDate var="dateString" value='${club.cbDate}' pattern="yyyy-MM-dd'T'HH:mm" />
		            <p class="limitmem"><fmt:formatDate value="${dateString}" pattern="M월 d일  E'요일' a h시  m분" /></p>
					-->
					
		         </a>
		      </div>
		   </c:forEach>
		</div>


	<div class='pull-right'>
		<ul class="pagination">
			<c:if test="${pageMaker.prev}">
				<li class="paginate_button previous"><a href="${pageMaker.startPage-1}">🦄</a></li>
			</c:if>

			<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
				<li class="paginate_button ${pageMaker.cri.pageNum==num ? "active":""} "><a href="${num}">${num}</a></li>
			</c:forEach>

			<c:if test="${pageMaker.next}">
				<li class="paginate_button next"><a href="${pageMaker.endPage+1}"> 🍉</a></li>
			</c:if>

		</ul>
	</div>



	<!-- input- hidden으로 controller에 넘겨줘야 하는 값들 -->
	<form id='actionForm' action="/thunder/list" method='get'>
		<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
		<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
		<input type='hidden' name='category' value='<c:out value="${pageMaker.cri.category}"/>'>
		<input type='hidden' name='subclass' value='<c:out value="${pageMaker.cri.subclass}"/>'>
		<input type='hidden' name='city' value='<c:out value="${pageMaker.cri.city}"/>'>
		<input type='hidden' name='district' value='<c:out value="${pageMaker.cri.district}"/>'>
		<input type='hidden' name='searchBy' value='<c:out value="${pageMaker.cri.searchBy}"/>'>
		<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>'>
		<input type='hidden' name='orderBy' value='<c:out value="${pageMaker.cri.orderBy}"/>'>

		<!-- list.jsp로 어디서 오는지를 몰라서, 리스트 올 떄마다 값을 전달하는 방식으로! -->
		<input type="hidden" name="userLatitude" value='<c:out value="${pageMaker.cri.userLatitude}"/>'>
		<input type="hidden" name="userLongitude" value='<c:out value="${pageMaker.cri.userLongitude}"/>'>
	</form>

</section>






<script type="text/javascript">
                  /* 외부 JS에서 JSTL이 적용되지 않아서, 내부스크립트의 var를 써서 해결 */
                  var cg = '${pageMaker.cri.category}';
                  var sc = '${pageMaker.cri.subclass}';
                  var ct = '${pageMaker.cri.city}';
                  var dt = '${pageMaker.cri.district}';
                  var searchBy = '${pageMaker.cri.searchBy}';                  
                  
                  
                  
               // 페이징버튼처리
                  /* var header = document.getElementById("myDIV");
                  var btns = header.getElementsByClassName("btn");
                  for (var i = 0; i < btns.length; i++) {
                      btns[i].addEventListener("click", function() {
                      var current = document.getElementsByClassName("active");
                      current[0].className = current[0].className.replace(" active", "");
                      this.className += " active";
                          });
                      } */
                      
                          
                      //3초마다 한번씩 릴로드 되게끔!
                      function test() {
                  		/* $.ajax({
                  			url : "/thunder/list",
                  			type : "GET",
                  			success:function(data) {
                  				$("#result").text(data);
                  				console.log("성공")
                  				},
                  			error:function() {console.log("실패")}
                  		}) */		
                  		
                  		actionForm.submit();
                  		/* location.href="/thunder/list"; */
                  	}
                  	
//                   	1분마다 새로고침 됨
//                   	timerId = setInterval(test, 60000);
//                   	console.log(timerId);
				</script>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- 렌더링을 거의 마치고 JS를 해석 할 것  -->
<script type="text/javascript" src="/resources/js/thunderList.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

<%@include file="../includes/footer.jsp"%>

