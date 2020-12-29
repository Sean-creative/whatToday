<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../includes/header.jsp"%>

<link rel="stylesheet" href="<c:url value='/resources/css/search.css'/>">


<div id="regusearch" style="width: 1200px; margin: 0 auto;">
	<form action="/regular/list" method="get" id="regularForm">

		<div id="them">
			<div style="margin-top: 70px;">
				<span style="font-size: 25px; font-weight: bold; background: linear-gradient(to top, rgba(255, 175, 49, 0.7) 50%, transparent 50%);">정기모임</span>
				<p>정기모임 검색결과입니다.</p>
			</div>
			<div style="margin-top: 70px;">
				<a href="" style="color: #999; font-weight: bold;">상세검색 > </a>
			</div>
		</div>

		<div style="margin-bottom: 20px;">

			<div style="margin-top: 20px; display: flex; justify-content: flex-start; flex-wrap: wrap;">

				<c:forEach items="${list}" var="club">
					<div class="regbox" onclick='linkToInfo2(${club.cbNum})' id='itemDiv${status.count}'>
						${status.count}<br>

						<ul class="demo">
							<li><img src="/resources/img/paint.jpg" alt="" style="width: 270px; height: 200px; border-radius: 15px;"></li>
							<li><p class="location"><c:out value="${club.cbDistrict}" /></p></li>
							<li><p class="nombre"><c:out value="${club.cbName}" /></p></li>
							<hr style="color: #eee;">
							<li><p class="limitmem">인원:<c:out value="${club.cbCurMbNum}" />/<c:out value="${club.cbMbNum}" /></p></li>
						</ul>
					</div>
				</c:forEach>
			</div>
		</div>
	<input type='hidden' name='searchBy' value='모임종류'>
	</form>
</div>

<hr style="width: 1200px; margin: 0 auto;">




<!--번개모임 -->
<div id="thundersearch" style="width: 1200px; margin: 0 auto;">
	<form action="/thunder/list" method="get" id="thunderForm">

		<div id="them">
			<div style="margin-top: 70px;">
				<span style="font-size: 25px; font-weight: bold; background: linear-gradient(to top, rgba(255, 175, 49, 0.7) 50%, transparent 50%);">번개모임</span>
				<p>번개모임 검색결과입니다.</p>
			</div>

			<div style="margin-top: 70px;">
				<a href="" style="color: #999; font-weight: bold;">상세검색 > </a>
			</div>
		</div>

		<div style="margin-bottom: 20px;">

			<div style="margin-top: 20px; display: flex; justify-content: flex-start; flex-wrap: wrap;">

				<c:forEach items="${clublist}" var="club2" varStatus="status">
					<div class="regbox" onclick='linkToInfo(${club2.cbNum})' id='itemDiv${status.count}'>

						<ul class="demo">
							<li><img src="/resources/img/paint.jpg" alt="" style="width: 270px; height: 200px; border-radius: 15px;"></li>

							<li><p class="location"><c:out value="${club2.cbDistrict}" /></p></li>

							<li><p class="nombre"><c:out value="${club2.cbName}" /></li>

							<li><fmt:parseDate var="dateString" value="${club2.cbDate}" pattern="yyyy-MM-dd'T'HH:mm" /> <fmt:formatDate value="${dateString}" pattern="M월 d일  E'요일' a h시  m분" /></li>

							<hr style="color: #eee;">

							<li><p class="limitmem">인원:<c:out value="${club2.cbCurMbNum}" />/<c:out value="${club2.cbMbNum}" /></p></li>
						</ul>
					</div>
				</c:forEach>
			</div>
		</div>
		
		<input type='hidden' name='searchBy' value='모임종류'>
		<input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>
	</form>
</div>


<script type="text/javascript">


let regularForm = $("#regularForm");
let thunderForm = $("#thunderForm");

//정기모임 DIV에 클릭
const linkToInfo2 = function(cbNum) {

	regularForm.append("<input type='hidden' name='cbNum' value='" + cbNum
			+ "'>");
	regularForm.attr("action", "/regular/info");
	regularForm.submit();
}

// 번개모임 DIV에 클릭
const linkToInfo = function(cbNum) {
	thunderForm.append("<input type='hidden' name='cbNum' value='" + cbNum
			+ "'>");
	thunderForm.attr("action", "/thunder/info");
	thunderForm.submit();
}


// 정렬 버튼을 눌렀을 떄!
$("#regularForm a").on("click", function(e) {
	e.preventDefault();
	console.log('#regularForm 더 보기 click');
	actionForm.find("input[name='orderBy']").val($(this).attr("href"));
	regularForm.submit();
});



//정렬 버튼을 눌렀을 떄!
$("#thunderForm a").on("click", function(e) {
	e.preventDefault();
	console.log('#thunderForm 더 보기 click');	
	thunderForm.submit();
});


</script>

<%@ include file="../includes/footer.jsp"%>

</body>
</html>
