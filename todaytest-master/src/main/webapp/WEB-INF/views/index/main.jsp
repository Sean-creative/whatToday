<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<%@ include file="../includes/header.jsp"%>

<link rel="stylesheet" href="<c:url value='/resources/css/main.css'/>">


    <!-- main사진  -->
     <div id="banner">
        <div class="foto"></div>
        <h1>오늘 뭐하지?</h1>
        <h3>당신의 즐거운 취미를 <br> 찾아드립니다!</h3>
        <div class="hobbytest"><a href="/hobbyTest/test">취미테스트</a></div>
        <div class="hobbytest hbtn"><a href="/regular/list">정기모임</a></div> 
    </div>
    <!--  정기모임 -->
   <div id="toregular">
        <span>정기모임</span>
        <span class="more"><a href="/regular/list">더보기+</a></span>
        <ul class="boxlist">
					 <c:forEach items="${main}" var="club" varStatus="status" begin="0" end="5">
						<li>
							<div class="regm">
								
								<a href='/regular/info?cbNum=<c:out value="${club.cbNum}" />'>
								<p>위치 : <c:out value="${club.cbCity}" /></p>
								<p>현재정원 : <c:out value="${club.cbCurMbNum}" /></p>
								<p>모임이름 : <c:out value="${club.cbName}" /></p>
								</a>
							</div>
						</li>	
					</c:forEach> 
        </ul>
    </div> 
    <div id="sub">
        <p class="hhh">지금 뭐하지?</p>
        <ul>
	          <c:forEach items="${main2}" var="club" varStatus="status" begin="1" end="16">
							<li>
							    <a href='/thunder/info?cbNum=<c:out value="${club.cbNum}" />'>
								<p>위치 : <c:out value="${club.cbCity}" /></p>
								<p>현재정원 : <c:out value="${club.cbCurMbNum}" /></p>
								<p>모임이름 : <c:out value="${club.cbName}" /></p>
								<p>유형  : <c:out value="${club.cbType}" /></p>
								</a>
							</li>	
				</c:forEach>
        </ul>
    </div>


<%@ include file="../includes/footer.jsp"%> 
    
</body>
</html>
    