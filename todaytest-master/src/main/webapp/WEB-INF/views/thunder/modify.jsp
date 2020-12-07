<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!-- 작성자 : 김선우 -->
<link rel="stylesheet" type="text/css" href="/resources/css/kakaoMap.css">

<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" type="text/css" href="/resources/css/thunder.css">

<!--  번개 모임 개설 -->
<section id="wrap">
	<form role="form" action="/thunder/modify" id="modifyForm" method="post" >

		<div>
			<div>
				모임명<br>				
				<input type="text" required="required" name='cbName' size="50" style="border: 1px solid #ff9f40; padding: 3px 0px;"
				value='<c:out value="${clubVO.cbName}" />'>
			</div>

		</div>


		<div style="float: left; margin-right: 50px">
			<div style="margin: 2px 0px">
				<img src="/resources/img/thunderImg.png" width="110" height="110" alt="번개대표사진">
			</div>
			<br>

			<button type="button">사진변경</button>

		</div>


		<div>
			<div>
				모임 날짜<br>
				<%-- <input type="datetime-local" name='thunderDetailVO.cbDate' id=cbDate value='<c:out value="${clubVO.thunderDetailVO.cbDate}" />'> --%>
				<input type="datetime-local" required="required" name='thunderDetailVO.cbDate' id='cbDate' style="border: 1px solid #ff9f40; padding: 3px 0px;"
				value='<c:out value="${clubVO.thunderDetailVO.cbDate}" />'>
				
			</div>
			<div>

				카테고리/분야<br>
				<script type="text/javascript">
					/* 외부 JS에서 JSTL이 적용되지 않아서, 내부스크립트의 var를 써서 해결 */
					var cg = '${clubVO.cbCategory}';
					var sc = '${clubVO.cbSubcat}';
					var ct = '${clubVO.cbCity}';
					var dt = '${clubVO.cbDistrict}';
				</script>
				<select name="cbCategory" id=category required="required" style="border: 1px solid #ff9f40; padding: 3px 0px;"></select>
			</div>

			<div>
				모임<br>
				<select name="cbSubcat" id="subcat" required="required"  style="border: 1px solid #ff9f40; padding: 3px 0px;"></select>
			</div>
		</div>


		<div>
			<div>
				모임 인원<br>
				<input type="number" name='cbMbnum' min="1" max="1000000" value='<c:out value="${clubVO.cbMbnum}"/>' required="required"style="border: 1px solid #ff9f40; padding: 3px 0px;">
				
			</div>

			<div>
				모임 마감기간<br>
				<input type="datetime-local" name='thunderDetailVO.cbAppPeriod' id=cbAppPeriod value='<c:out value="${clubVO.thunderDetailVO.cbAppPeriod}" />'
				required="required" style="border: 1px solid #ff9f40; padding: 3px 0px;">
				
			</div>

			<div>
				해시태그<br>
				<input type="text" name='cbHashtag' value='<c:out value="${clubVO.cbHashtag}" />'>
			</div>
		</div>


	<!-- 	<div>
			<div>
				지역 <br>
				<select name="cbCity" id="city"></select>
			</div>
			<div>
				세부지역<br>
				<select name="cbDistrict" id="district"></select>
			</div>
		</div> -->
		
		<div>
			<div>
				모임 지역 <br>
				<!-- 값이 '서울 종로구' 이런식으로 들어오는데,
                  1. js단에서  ','를 기준으로 값을 분리해주면 되겠다. -->
				<input type="text" required="required" readonly="readonly" name='thunderDetailVO.cbAddress' id='cbAddress' style="border: 1px solid #ff9f40; padding: 3px 0px;"
				value='<c:out value="${clubVO.thunderDetailVO.cbAddress}" />'>
			</div>
		</div>
		
		
		<div>
			<div>
				모임 장소 <br>
				<input type="text" name='thunderDetailVO.cbPlace' id=cbPlace value='<c:out
						value="${clubVO.thunderDetailVO.cbPlace}" />' required="required" readonly="readonly" style="border: 1px solid #ff9f40; padding: 3px 0px;">				 
			</div>

			<div>
				모임 준비물<br>
				<input type="text" name='thunderDetailVO.cbSupplies' id=cbSupplies value='<c:out value="${clubVO.thunderDetailVO.cbSupplies}" />'>
			</div>
		</div>



		<div>
			모임소개<br>
			<!-- 300자 제한 -->
			<textarea name='cbIntro' cols="100" rows="7" maxlength="300"><c:out value="${clubVO.cbIntro}" /></textarea>
		</div>

		<div style="margin-left: 470px">
			<button type="submit" data-oper='modify' class="btn btn-default">Modify</button>

			<button type="submit" data-oper='remove' class="btn btn-default">Remove</button>

			<button type="submit" data-oper='list' class="btn btn-default">List</button>
		</div>

		<input type='hidden' id='cbNum' name='cbNum' value='<c:out value="${clubVO.cbNum}"/>'>
		<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
		<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
		<input type='hidden' name='category' value='<c:out value="${cri.category}"/>'>
		<input type='hidden' name='subclass' value='<c:out value="${cri.subclass}"/>'>
		<input type='hidden' name='city' value='<c:out value="${cri.city}"/>'>
		<input type='hidden' name='district' value='<c:out value="${cri.district}"/>'>
		<input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>
		
		<!-- 지역 이름 정도만 컨트롤러에 보낸다. -->
		<input type='hidden' name='cbCity' value='<c:out value="${clubVO.cbCity}"/>'>
		<input type='hidden' name='cbDistrict' value='<c:out value="${clubVO.cbDistrict}"/>'>
		<input type='hidden' name='thunderDetailVO.cbLocation' id='cbLocation' value='<c:out value="${clubVO.thunderDetailVO.cbLocation}"/>'>		
		
		<!-- 업데이트가 되어있어야 하기때문에, mapper.xml의 update에 있는 속성은 전달해야함-->
		<input type='hidden' name='cbCurMbnum' value='<c:out value="${clubVO.cbCurMbnum}"/>'>		
		<%-- <input type='hidden' name='cbShutDate' value='<c:out value="${clubVO.cbShutDate}"/>'  id='cbDate'> --%>		
		
		
	</form>
	
	
	<div class="map_wrap">
		<div id="map" style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>

		<div id="menu_wrap" class="bg_white">
			<div class="option">
				<div>

					<form role="form" onsubmit="searchPlaces(); return false;">
						모임 장소 :
						<input type="text" value="종각역" id="keyword" size="15" style="border: 1px solid #ff9f40; padding: 3px 0px;">
						<button type="submit">검색하기</button>


					</form>
				</div>
			</div>
			<hr>
			<ul id="placesList"></ul>
			<div id="pagination"></div>
		</div>
	</div>
	
	
</section>



<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- 렌더링을 거의 마치고 JS를 해석 할 것  -->
<script type="text/javascript" src="/resources/js/thunderModify.js"></script>

<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e19ea28cff4b871b68b2fabda7855cab&libraries=services,clusterer,drawing"></script>

<script type="text/javascript" src="/resources/js/kakaoMap.js"></script>



<%@include file="../includes/footer.jsp"%>






