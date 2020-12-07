
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!-- 작성자 : 김선우 -->

<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" type="text/css" href="/resources/css/thunder.css">



<!--  번개 모임 개설 -->
<section id="wrap" style="border: 1px solid; margin-top: 30px; padding: 30px;">
	<form action="/thunder/list" method="get" onsubmit="return inputCheck()">


		<div style="font-size: 30px; margin-bottom: 20px;">
			<b>전체모임</b>
		</div>

		<!-- 상세검색창 -->
		<div style="border: 1px solid black; padding: 20px; background-color: lightgray;">
			<div style="font-size: 20px; margin: 0px;">상세검색</div>
			<div style="margin-top: 20px; display: flex; justify-content: space-between;">


				<script type="text/javascript">
                  /* 외부 JS에서 JSTL이 적용되지 않아서, 내부스크립트의 var를 써서 해결 */
                  var cg = '${pageMaker.cri.category}';
                  var sc = '${pageMaker.cri.subclass}';
                  var ct = '${pageMaker.cri.city}';
                  var dt = '${pageMaker.cri.district}';
			</script>


				<!-- name은 ThunderVO가 아닌, Criteria의 변수명으로 맞춰줘야한다. -->
				<select name='category' id='category' style="width: 220px; height: 40px; font-size: 20px;"></select>

				<!-- DB의 컬럼명이 subclass에서 subcat으로 바뀌면서, 코드내에 Criteria를 사용하는 곳은 다 바꿔야함 -->
				<select name='subclass' id='subcat' style="width: 220px; height: 40px; font-size: 20px;"></select>
				<select name='city' id='city' style="width: 220px; height: 40px; font-size: 20px;" id="city"></select>

				<select name='district' id='district' style="width: 220px; height: 40px; font-size: 20px;"></select>

			</div>



			<div>
				<div>
					<input type="text" name='keyword' style="width: 600px; height: 30px; font-size: 20px;" value='<c:out value="${pageMaker.cri.keyword}"/>' />

					<button style="width: 100px; height: 35px;">검색</button>
				</div>
			</div>
		</div>




		<div style="padding: 20px;">
			<div style="font-size: 20px; margin: 0px;">최신순 인기순 마감임박순</div>
			<div style="margin-top: 20px; display: flex; justify-content: space-between;">


				<c:forEach items="${list}" var="thunderItem" varStatus="status">
					<div style="border: 1px solid black; width: 170px; height: 140px; cursor: pointer;" class='move' onclick='linkToInfo(${thunderItem.cbNum})'
					id ='itemDiv${status.count}'>								
						${status.count}<br>
						
						[모임명] :
						<c:out value="${thunderItem.cbName}" />
						<br> [일 정] :						
						<fmt:parseDate var="dateString" value="${thunderItem.thunderDetailVO.cbDate}" pattern="yyyy-MM-dd'T'HH:mm" />						
						<fmt:formatDate value="${dateString}" pattern="M월 d일  E'요일' a h시  m분"/>
						
						<br> [장 소] :
						<c:out value="${thunderItem.cbDistrict}" />
						<br> [인 원] :
						<c:out value="${thunderItem.cbCurMbnum}" />
						/
						<c:out value="${thunderItem.cbMbnum}" />
					</div>
				</c:forEach>
			</div>
		</div>
	</form>

	<div class='pull-right'>
		<ul class="pagination">
			<c:if test="${pageMaker.prev}">
				<li class="paginate_button previous"><a href="${pageMaker.startPage-1}">Previous</a></li>
			</c:if>

			<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
				<li class="paginate_button ${pageMaker.cri.pageNum==num ? "active":""} "><a href="${num}">${num}</a></li>
			</c:forEach>

			<c:if test="${pageMaker.next}">
				<li class="paginate_button next"><a href="${pageMaker.endPage+1}"> Next</a></li>
			</c:if>

		</ul>
	</div>

	<form id='actionForm' action="/thunder/list" method='get'>
		<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
		<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>

		<input type='hidden' name='category' value='<c:out value="${pageMaker.cri.category}"/>'>
		<input type='hidden' name='subclass' value='<c:out value="${pageMaker.cri.subclass}"/>'>
		<input type='hidden' name='city' value='<c:out value="${pageMaker.cri.city}"/>'>
		<input type='hidden' name='district' value='<c:out value="${pageMaker.cri.district}"/>'>
		<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>'>
	</form>

</section>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>


<!-- 렌더링을 거의 마치고 JS를 해석 할 것  -->
<script type="text/javascript" src="/resources/js/thunderList.js"></script>

<%@include file="../includes/footer.jsp"%>


