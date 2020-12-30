<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" href="../resources/css/clubListStyle.css">

<section id="wrap">
<form action="/regular/list" method="get" onsubmit="return inputCheck()">

	  <!-- 상세검색창 -->
      <div id="detsrc">
         <div class="src">

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
               
                  <input type='text' id='keyword' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>' placeholder="관심 취미를 검색해주세요" />
                  <button class="btnkeyword" >
                     <img src="/resources/img/search.png" alt="">
                  </button>                           
            </div>
		 </div>
      </div>
	
</form>

		<div id="sort">
			<ul>
				<span class="half">정기모임</span>
            	<li class="order_button ${pageMaker.cri.orderBy eq 'cbNum desc'? "active":""} "><a href="cbNum desc">최신순</a></li>
				<li class="order_button ${pageMaker.cri.orderBy eq 'cbView desc'? "active":""} "><a href="cbView desc">인기순</a></li>
        	</ul>
		</div>
		
		<!-- 검색결과  -->		
		<div id="searchresult">	
			<c:forEach items="${clublist}" var="club"> 
				<div class='move' onclick='linkToInfo(${club.cbNum})' id ='itemDiv${status.count}'>${status.count}<br>
					<img src="${club.cbThumbImg}" alt="">
					<p class="location"><c:out value="${club.cbDistrict}" /></p>
					<p class="nombre"><c:out value="${club.cbName}" /></p>
					<hr style="color:#eee;">
					<p class="limitmem">모집인원 : <c:out value="${club.cbCurMbNum}" /> / <c:out value="${club.cbMbNum}" /></p>					
				</div>
			</c:forEach>
		</div>

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

	<form id='actionForm' action="/regular/list" method='get'>
		<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'/>
		<input type='hidden' name='amount' value='${pageMaker.cri.amount}'/>

		<input type='hidden' name='category' value='<c:out value="${pageMaker.cri.category}"/>'/>
		<input type='hidden' name='subclass' value='<c:out value="${pageMaker.cri.subclass}"/>'/>
		<input type='hidden' name='city' value='<c:out value="${pageMaker.cri.city}"/>'/>
		<input type='hidden' name='district' value='<c:out value="${pageMaker.cri.district}"/>'/>
		<input type='hidden' name='searchBy' value='<c:out value="${pageMaker.cri.searchBy}"/>'>
		<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>'/>
		<input type='hidden' name='orderBy' value='<c:out value="${pageMaker.cri.orderBy}"/>'/>
	</form>
</section>


<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- 렌더링을 거의 마치고 JS를 해석 할 것  -->
<script type="text/javascript" src="/resources/js/regularList.js"></script>

<script type="text/javascript">
                  /* 외부 JS에서 JSTL이 적용되지 않아서, 내부스크립트의 var를 써서 해결 */
                  var cg = '${pageMaker.cri.category}';
                  var sc = '${pageMaker.cri.subclass}';
                  var ct = '${pageMaker.cri.city}';
                  var dt = '${pageMaker.cri.district}';
                  var searchBy = '${pageMaker.cri.searchBy}';    
                  
                  if (searchBy == null) {
              		$("#searchBy option[value='모임명']").attr('selected', 'selected');
              	} else {
              		$("#searchBy option[value='" + searchBy + "']").attr('selected',
              				'selected');
              	}
</script>

<%@include file="../includes/footer.jsp"%>

<%-- <div id="body">
	<c:forEach items="${clublist}" var="club" varStatus="status" begin="0" end="19"> <!--20개 목록만 보여주기-->
		<div class="box">
			<ul class="demo">
				<li>모임명:<a href='/regular/info?cbNum=<c:out value="${club.cbNum}" />'> <!--cbNum(모임번호)을 가지고 모임상세 페이지이동-->
						<c:out value="${club.cbName}" /></a></li>
				<li>지역:<c:out value="${club.cbDistrict}" /></li>
				<li>현재인원:<c:out value="${club.cbCurMbNum}" /></li>
			</ul>
		</div>
	</c:forEach>
</div> --%>

<%-- <select class="pagination">
	<option value="CBNUM" <c:if test="${pageMaker.cri.orderBy eq 'CBNUM'}">selected</c:if>>최신순</option> <!-- DB 필드명을 넣어야함, java vo는 DB가 인식을 못하지 (cbNum : X) -->
	<option value="CBVIEW" <c:if test="${pageMaker.cri.orderBy eq 'CBVIEW'}">selected</c:if>>인기순</option>
</select>  --%>