<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- 작성자 : 김선우 -->

<%@include file="../includes/header.jsp"%>

<link rel="stylesheet" type="text/css"
	href="/resources/css/kakaoMap.css">

<!--  번개 모임 개설 -->
<section id="wrap">
	<form action="/thunder/add" method="post" name="add"
		onsubmit="return inputCheck()">

		<div>
			<div>
				모임명<br>
				<!-- 30자 제한 -->
				<input type="text" required="required" name='cbName' size="50"
					style="border: 1px solid #ff9f40; padding: 3px 0px;">
			</div>

		</div>


		<div style="float: left; margin-right: 50px">
			<div style="margin: 2px 0px">
				<img src="/resources/img/thunderImg.png" width="110" height="110"
					alt="번개대표사진">
			</div>
			<br>

			<button type="button">사진변경</button>

		</div>


		<div>
			<div>
				모임 날짜<br>
				<!-- date 타입을 비동기적으로(실시간으로) 계속 찍어줘야 할듯
					ex) 1분차이로 현재의 시간이 과거가 될 수 도 있다. -->
				<!-- JS로 MIN과 MAX를 찍어주자 -->
				<input type="datetime-local" required="required"
					name='thunderDetailVO.cbDate' id='cbDate'
					style="border: 1px solid #ff9f40; padding: 3px 0px;">
			</div>
			<div>
				카테고리/분야<br> <select name="cbCategory" required="required"
					id='category' style="border: 1px solid #ff9f40; padding: 3px 0px;"></select>
			</div>

			<div>
				모임<br> <select name="cbSubcat" required="required" id="subcat"
					style="border: 1px solid #ff9f40; padding: 3px 0px;">
					<option value="모임 선택" selected>모임 선택
				</select>
			</div>
		</div>


		<div>
			<div>
				모임 인원<br> <input type="number" required="required"
					name='cbMbnum' min="1" max="1000000"
					style="border: 1px solid #ff9f40; padding: 3px 0px;">
			</div>

			<div>
				모임 마감기간<br> <input type="datetime-local" required="required"
					name='thunderDetailVO.cbAppPeriod' id='cbAppPeriod'
					style="border: 1px solid #ff9f40; padding: 3px 0px;">
			</div>

			<div>
				해시태그<br> <input type="text" name='cbHashtag'>
			</div>
		</div>


		<!--   <div>
                <div>
                  지역 <br>
                  <select name="cbCity" id="city">
                  <option value="지역 선택" >지역 선택</option>                  
                  <option value="서울특별시" >서울특별시</option>                  
                  <option value="경기도" >경기도</option>                  
                  </select>
                </div>
                <div>
                  세부지역<br>
                  <select name="cbDistrict" id="district">
                  <option value="세부지역 선택">세부지역 선택</option> 
                  </select>
                </div>
          </div> -->




		<div>
			<div>
				모임 지역 <br>
				<!-- 값이 '서울 종로구' 이런식으로 들어오는데,
                  1. js단에서  ','를 기준으로 값을 분리해주면 되겠다. -->
				<input type="text" required="required" readonly="readonly"
					name='thunderDetailVO.cbAddress' id='cbAddress'
					style="border: 1px solid #ff9f40; padding: 3px 0px;">
			</div>
		</div>

		<div>
			<div>
				모임 장소 <br> <input type="text" required="required"
					readonly="readonly" name='thunderDetailVO.cbPlace' id='cbPlace'
					style="border: 1px solid #ff9f40; padding: 3px 0px;">
			</div>

			<div>
				모임 준비물<br> <input type="text" name='thunderDetailVO.cbSupplies'
					id='cbSupplies' size="50">
			</div>
		</div>

		<div>
			모임소개<br>
			<!-- 300자 제한 -->
			<textarea name='cbIntro' cols="100" rows="7" maxlength="300"></textarea>
		</div>

		<div style="margin-left: 470px">
			<button type="submit">번개만들기</button>
			<button type="reset" onclick="alert('리셋되었습니다.')">리셋 하기</button>
		</div>


	<!-- 지역 이름 정도만 컨트롤러에 보낸다. -->
	<input type='hidden' name='cbCity'> 
	<input type='hidden' name='cbDistrict'> 
	<input type='hidden' name='thunderDetailVO.cbLocation' id='cbLocation'> 

	</form>



		

	<div class="map_wrap">
		<div id="map"
			style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>

		<div id="menu_wrap" class="bg_white">
			<div class="option">
				<div>

					<form role="form" onsubmit="searchPlaces(); return false;">
						모임 장소 : <input type="text" value="종각역" id="keyword" size="15"
							style="border: 1px solid #ff9f40; padding: 3px 0px;">
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
<script src="http://code.jquery.com/jquery-3.3.1.js"></script>

<!-- 렌더링을 거의 마치고 JS를 해석 할 것  -->
<script type="text/javascript" src="/resources/js/thunderAdd.js"></script>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e19ea28cff4b871b68b2fabda7855cab&libraries=services,clusterer,drawing"></script>

<script type="text/javascript" src="/resources/js/kakaoMap.js"></script>

<%@include file="../includes/footer.jsp"%>