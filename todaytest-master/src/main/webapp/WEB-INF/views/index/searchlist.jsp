<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<%@ include file="../includes/header.jsp"%>

<link rel="stylesheet" href="<c:url value='/resources/css/search.css'/>">


<div id="regusearch" style="width:1200px; margin:0 auto;">
 <form action="/regular/list" method="get" id="actionForm2">

    <div id="them">
		<div style="margin-top:70px;">
			<span style="font-size: 25px; font-weight:bold; background:linear-gradient(to top, rgba(255,175,49,0.7) 50%, transparent 50%);">정기모임</span>
			<p>정기모임 검색결과입니다.</p>
		</div>
		<div style="margin-top:70px;"><a href="" style="color:#999; font-weight:bold;">상세검색 > </a></div>
	</div>
	
	<div style="margin-bottom: 20px;">
		
		<div style="margin-top: 20px; display: flex; justify-content:flex-start; flex-wrap:wrap;">

			<c:forEach items="${clublist}" var="club">
				<div class="regbox" onclick='linkToInfo2(${club.cbNum})' id ='itemDiv${status.count}'>								
					${status.count}<br>
						
					<ul class="demo">
						<li><img src="/resources/img/paint.jpg" alt="" style="width:270px; height:200px;border-radius: 15px;"></li>
						<li><p class="location"><c:out value="${club.cbDistrict}" /></p></li>
						<li><p class="nombre"><c:out value="${club.cbName}" /></p></li>
						<hr style="color:#eee;">
						<li><p class="limitmem">인원:<c:out value="${club.cbCurMbNum}" />/<c:out value="${club.cbMbNum}" /></p></li>
					</ul>
				</div>
			</c:forEach>
		</div>
	</div>
	
	
</form>
</div> 

<hr style="width:1200px; margin:0 auto;">

<!--번개모임 -->

<div id="thundersearch" style="width:1200px; margin:0 auto;">
 <form action="/thunder/list" method="get" id="actionForm">

    <div id="them">
		<div style="margin-top:70px;">
			<span style="font-size: 25px; font-weight:bold; background:linear-gradient(to top, rgba(255,175,49,0.7) 50%, transparent 50%);">번개모임</span>
			<p>번개모임 검색결과입니다.</p>
		</div>
		<div style="margin-top:70px;"><a href="" style="color:#999; font-weight:bold;">상세검색 > </a></div>
	</div>
	
	<div style="margin-bottom: 20px;">
		
		<div style="margin-top: 20px; display: flex; justify-content:flex-start; flex-wrap:wrap;">

			<c:forEach items="${list}" var="thunderItem" varStatus="status">
				<div class="regbox" onclick='linkToInfo(${thunderItem.cbNum})' id ='itemDiv${status.count}'>								
					${status.count}<br>
						
					<ul class="demo">
						<li><img src="/resources/img/paint.jpg" alt="" style="width:270px; height:200px;border-radius: 15px;"></li>
						
						<li><p class="location"><c:out value="${thunderItem.cbDistrict}" /></p></li>
						
						<li><p class="nombre"><c:out value="${thunderItem.cbName}" /></li>
						
						<li><fmt:parseDate var="dateString" value="${thunderItem.thunderDetailVO.cbDate}" pattern="yyyy-MM-dd'T'HH:mm" />						
						<fmt:formatDate value="${dateString}" pattern="M월 d일  E'요일' a h시  m분"/></li>
						
						<hr style="color:#eee;">
						
						<li><p class="limitmem">인원:<c:out value="${thunderItem.cbCurMbnum}" />/<c:out value="${thunderItem.cbMbnum}" /></p></li>
					</ul>
				</div>
			</c:forEach>
		</div>
	</div>
</form>
</div> 

<!-- 번개  -->
<%-- <form action="/thunder/list" method="get" id="actionForm">
		<div style="font-size: 30px; margin-bottom: 20px;">
			<b>번개모임</b>
		</div>
		<div style="padding: 20px; width:1200px; margin: 0 auto;">
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
</form> --%>

<script type="text/javascript">
actionForm = $("#actionForm");
actionForm = $("#actionForm2");
const linkToInfo = function(cbNum) {

	actionForm.append("<input type='hidden' name='cbNum' value='" + cbNum
			+ "'>");
	actionForm.attr("action", "/thunder/info");
	actionForm.submit();
}

const linkToInfo2 = function(cbNum) {

	actionForm.append("<input type='hidden' name='cbNum' value='" + cbNum
			+ "'>");
	actionForm.attr("action", "/regular/info");
	actionForm.submit();
}
</script>

<%@ include file="../includes/footer.jsp"%> 
    
</body>
</html>
    