<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<%@ include file="../includes/header.jsp"%>

<link rel="stylesheet" href="<c:url value='/resources/css/main.css'/>">

<form action="/thunder/list" method="get" onsubmit="return inputCheck()">


		<div style="font-size: 30px; margin-bottom: 20px;">
			<b>전체모임</b>
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


<%@ include file="../includes/footer.jsp"%> 
    
</body>
</html>
    