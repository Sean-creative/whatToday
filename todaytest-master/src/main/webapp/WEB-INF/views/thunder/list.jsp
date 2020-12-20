
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!-- 작성자 : 김선우 -->

<%@include file="../includes/header.jsp"%>



<link rel="stylesheet" type="text/css" href="/resources/css/thunderList.css">

<section id="wrap">

	<form action="/thunder/list" method="get" onsubmit="return inputCheck()">
	
		<!-- 상세검색창 -->
		<div id="search">
			<div id="searchform">
			
			
				<div id="selectThing">
					<div>
						<label>관심분야</label>
						<!-- name은 ThunderVO가 아닌, Criteria의 변수명으로 맞춰줘야한다. -->
						<select name='category' id='category'></select>
					</div>

					<div>
						<label>모임선택</label>
						<select name='subclass' id='subcat'></select>
					</div>
				</div>
				
				
				<div id="selectThing">
					<div>
						<label>관심지역</label>
						<select  name='city' id='city'></select>
					</div>


					<div>
						<label>세부지역</label>
						<select name='district' id='district'></select>
					</div>
				</div>
				
				


 			    <div id="nav">
 			    	<select name='searchBy' id='searchBy' style="width: 150px; height: 35px; font-size: 20px;">
						<option value='모임명'>모임명</option>
						<option value='글작성자'>글작성자</option>
						<option value='해시태그'>해시태그</option>
					</select>
                    <input type="text" name='keyword' placeholder="관심 취미를 검색해주세요." value='<c:out value="${pageMaker.cri.keyword}"/>'>
                    <button ></button>
                </div>



<%-- 				<div id="nav">
					<select name='searchBy' id='searchBy' style="width: 150px; height: 35px; font-size: 20px;">
						<option value='모임명'>모임명</option>
						<option value='글작성자'>글작성자</option>
						<option value='해시태그'>해시태그</option>
					</select>

					<input type="text" name='keyword' placeholder="관심 취미를 검색해주세요." value='<c:out value="${pageMaker.cri.keyword}"/>'>
					<button></button>
				</div> --%>

			</div>
		</div>
	</form>





	<div class="header_in3">   
        <ul class="header_weekday">          
        </ul>
    </div>





	<div id="sort">
		<ul>
			<li class="order_button ${pageMaker.cri.orderBy eq 'cbnum desc'? "active":""}" ><a href="cbnum desc">최신순</a></li>
			<li class="order_button ${pageMaker.cri.orderBy eq 'cbView desc'? "active":""}" ><a href="cbView desc">인기순</a></li>
			<li class="order_button ${pageMaker.cri.orderBy eq 'cbappperiod desc'? "active":""}" ><a href="cbappperiod desc">마감임박순</a></li>
			<li class="order_button ${pageMaker.cri.orderBy eq 'distance'? "active":""}"><a href="distance">거리순</a></li>						
		</ul>
	</div>


	<!-- 검색결과  -->
	<div id="searchresult">
		<c:forEach items="${list}" var="thunderItem" varStatus="status">
			<div class='move' onclick='linkToInfo(${thunderItem.cbNum})' id='itemDiv${status.count}'>

				<img src="${thunderItem.cbThumbImg}" alt="">
				<p class="location"><c:out value="${thunderItem.cbDistrict}" /></p>
				<p class="nombre"><c:out value="${thunderItem.cbName}" /></p>
				<hr style="color: #eee;">
				<fmt:parseDate var="dateString" value="${thunderItem.thunderDetailVO.cbDate}" pattern="yyyy-MM-dd'T'HH:mm" />
				
				<p class="limitmem"><fmt:formatDate value="${dateString}" pattern="M월 d일  E'요일' a h시  m분" /></p>
				<p class="limitmem">모집인원 : <c:out value="${thunderItem.cbCurMbnum}" /> / <c:out value="${thunderItem.cbMbnum}" /> 명				

			</div>
		</c:forEach>
	</div>





	<!-- 페이지 넘버링 -->
	<!-- <div id="myDIV">
        <button class="btn">1</button>
        <button class="btn active">2</button>
        <button class="btn">3</button>
        <button class="btn">4</button>
        <button class="btn">5</button>
    </div> -->
    
    
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
		<input type="hidden" name="userLatitude">
		<input type="hidden" name="userLongitude">
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
				</script>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- 렌더링을 거의 마치고 JS를 해석 할 것  -->
<script type="text/javascript" src="/resources/js/thunderList.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

<%@include file="../includes/footer.jsp"%>

