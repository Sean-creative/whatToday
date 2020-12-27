<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- 작성자 : 김선우 -->

<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" type="text/css" href="/resources/css/thunderAdd.css">
<link rel="stylesheet" type="text/css" href="/resources/css/kakaoMap.css">


<!-- 만남개설 -->
<section>
	<div class="section_header" style="margin: 0 auto 50px; text-align: center;">
		<span class="half">만남 개설</span>
		<p>간단하게 어떤 만남인지 알려주세요</p>
	</div>
	<div id="container">

		<!-- ========중앙========== -->
		<div class="section_in" style="display: inline-block; overflow: hidden">
			<form action="/meeting/add" method="post" onsubmit="return inputCheck()"
			style="padding-top: 36px;">
				<h6 class="form-stxt">*필수 입력사항&nbsp;&nbsp;</h6>
				<hr>
				<fieldset class="formContent">

					<div>
						<div style="display: inline-block; width: 300px;">
							<!-- 30자 제한 -->
							<label for="name" style="display: block;">만남명*</label>
							<input type="text" required="required" name='mtName' size="50" placeholder="만남명을 입력하세요">
						</div>

						<div style="display: inline-block; width: 300px;">
							<label for="request" class="class" style="display: block;">만남 인원*</label>
							<input type="number" required="required" name='mtMbNum' min="1" max="50">
						</div>
					</div>

					<div>
						<div style="display: inline-block; width: 300px;">
							<label for="hp">만남 날짜*</label>
							<input type="datetime-local" required="required" name='mtStartDate' id='mtStartDate'>
						</div>

						<!-- ======== 날씨 ========== -->
						<div class="header_in3">
							<ul class="header_weekday">
							</ul>
						</div>
					</div>


					<div>
						<div style="display: inline-block; width: 300px;">
							<label for="request" class="class">만남 지역*</label>
							<input type="text" required="required" readonly="readonly" name='mtAddress' id='cbAddress' placeholder="지도에서 마커를 클릭해주세요">
						</div>



						<div style="display: inline-block; width: 300px;">
							<label for="request" class="class">만남 장소 *</label>
							<input type="text" required="required" readonly="readonly" name='mtPlace' id='cbPlace' placeholder="지도에서 마커를 클릭해주세요">
						</div>
					</div>


					<div id="hash" style="display:block;">
						<div style="display: block; width: 300px;">
							<label for="request" class="class" style="display: block;">만남 준비물</label>
							<input type="text" name='mtSupplies' id='mtSupplies' size="50">
						</div>

						<div style="display: block; width: 300px;">
							<label for="request" class="class" style="display: block;">만남소개</label>
							<textarea name='mtIntro' cols="100" rows="7" maxlength="100"></textarea>
						</div>

					</div>

				</fieldset>

				<hr>

				<fieldset class="agreebox">
					<div class="btn_faq">
						<button type="submit" class="btn_faq2">만남만들기</button>
						<button type="reset" onclick="alert('리셋되었습니다.')" class="btn_faq2">리셋 하기</button>
					</div>
				</fieldset>


				<!-- 지역 이름 정도만 컨트롤러에 보낸다. -->
				<!-- <input type='hidden' name='cbCity'>
				<input type='hidden' name='cbDistrict'> -->

				<input type='hidden' name='thunderDetailVO.cbLatitude' id='cbLatitude'>
				<input type='hidden' name='thunderDetailVO.cbLongitude' id='cbLongitude'>

				<!-- 모임 번호정도만 컨트롤러에 보낸다. -->
				<input type="hidden" name="cbNum" value="<c:out value="${cbNum}" />" />
				<input type="hidden" name="cbName" value="${cbName}" />
			</form>

		</div>
		<!-- 중앙 끝  -->


		<!-- ========오른쪽========== -->
		<div style="display: inline-block; width: 700px; height: 820px; margin-top: 75px; margin-left: 40px;">

			<!-- 카카오 맵 영역 -->
			<div class="map_wrap">
				<div id="map"></div>
				<div id="menu_wrap" class="bg_white">
					<div class="option">
						<div>
							<form role="form" onsubmit="searchPlaces(); return false;">
								모임 장소 :
								<input type="text" value="종각역" id="keyword" size="15">
								<button type="submit">검색하기</button>
							</form>
						</div>
					</div>
					<hr>
					<ul id="placesList"></ul>
					<div id="pagination"></div>
				</div>
			</div>
			<!-- 카카오 맵 END -->

		</div>


	</div>
	<!-- 컨테이너 END -->
</section>







<!-- 렌더링을 거의 마치고 JS를 해석 할 것  -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e19ea28cff4b871b68b2fabda7855cab&libraries=services,clusterer,drawing"></script>

<script type="text/javascript" src="/resources/js/kakaoMap.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

<script>
	/* 날씨관련 */
	let city = 'Seoul';
	//날씨 DATA의 기준인 lat,lon은 종각역 YMCA 건물 기준임!!
	var apiURI = "https://api.openweathermap.org/data/2.5/onecall?lat=37.57041580586331&lon=126.98515148702204&exclude=current,minutely,hourly,alerts&appid=dfb19fd20ff326431f940b75f34778da&lang=kr&units=metric";
	$
			.ajax({
				url : apiURI,
				dataType : "json",
				type : "GET",
				async : "false",
				success : function(resp) {
					console.log("도시 이름 : " + resp.timezone.split('/')[1]);

					for ( let idx in resp.daily) {
						let tmp = '<li>';
						let days = new Date();
						days.setTime(resp.daily[idx].dt * 1000);
						const today = moment(days);

						tmp += '<h4>' + today.format('ddd') + '</h4>';

						if (resp.daily[idx].weather[0].icon == '01d'
								|| resp.daily[idx].weather[0].icon == '01n') {
							imgURL = '/resources/img/animation-ready/clear-day.svg';
						}
						// 맑고 구름
						if (resp.daily[idx].weather[0].icon == '02d'
								|| resp.daily[idx].weather[0].icon == '02n') {
							imgURL = '/resources/img/animation-ready/partly-cloudy-day.svg';
						}
						// 구름
						if (resp.daily[idx].weather[0].icon == '03d'
								|| resp.daily[idx].weather[0].icon == '03n') {
							imgURL = '/resources/img/animation-ready/cloudy.svg';
						}
						// 먹구름
						if (resp.daily[idx].weather[0].icon == '04d'
								|| resp.daily[idx].weather[0].icon == '04n') {
							imgURL = '/resources/img/animation-ready/cloudy.svg';
						}
						// 소나기
						if (resp.daily[idx].weather[0].icon == '09d'
								|| resp.daily[idx].weather[0].icon == '09d') {
							imgURL = '/resources/img/animation-ready/rain.svg';
						}
						// 비
						if (resp.daily[idx].weather[0].icon == '10d'
								|| resp.daily[idx].weather[0].icon == '10n') {
							imgURL = '/resources/img/animation-ready/rain.svg';
						}
						// 번개
						if (resp.daily[idx].weather[0].icon == '11d'
								|| resp.daily[idx].weather[0].icon == '11n') {
							imgURL = '/resources/img/animation-ready/thunderstorms.svg';
						}
						// 눈
						if (resp.daily[idx].weather[0].icon == '13d'
								|| resp.daily[idx].weather[0].icon == '13n') {
							imgURL = '/resources/img/animation-ready/snow.svg';
						}
						// 안개
						if (resp.daily[idx].weather[0].icon == '50d'
								|| resp.daily[idx].weather[0].icon == '50n') {
							imgURL = '/resources/img/animation-ready/mist.svg';
						}

						tmp += "<img src=" + imgURL + ">";

						tmp += '<p">' + Math.floor(resp.daily[idx].temp.min)
								+ '&ordm/'
								+ Math.floor(resp.daily[idx].temp.max)
								+ '&ordm</p>';

						tmp += "</li>"

						$('.header_weekday').append(tmp);
					}
				}
			})

			
	const dating = function(o) {
		// toSOSString()을 이용하기 위해서 사용
		// getTimezoneOffset()은 현재 시간과의 차이를 분 단위로 반환한다.
		const offset = new Date().getTimezoneOffset() * 60000;
		const today = new Date(Date.now() - offset);

		// toISOString()에서 리턴하는 'yyyy-MM-ddThh:mm:ss.sssZ'을 슬라이싱함		
		let nowDate = today.toISOString().slice(0, 16);

		//현재시간으로 부터 한 달 더해준 것이 maxDay
		today.setDate(today.getDate() + 28);
		let maxDay = today.toISOString().slice(0, 16);

		today.setDate(today.getDate() - 28);
		today.setHours(today.getHours() + 1);
		let minDay = today.toISOString().slice(0, 16);

		
		if ($(o).val()) {
			// 값을 입력한 후 일 때 Value는 냅둬야함

		} else if (!($(o).val())) {
			// date의 값이 아무것도 없을 때 (초기 설정일 때)는 초기 설정을 해준다
			// 초기 설정
			$('#mtStartDate').val(minDay);
		}
				
		
		$("#mtStartDate").attr('min', minDay);
		$("#mtStartDate").attr('max', maxDay);
	}

	

	dating();
	
	const inputCheck = function() {

		// 번개만들기를 클릭 했을 때, 날짜를 한번 더 업데이트 해준다음에 검사한다.
		dating($('#mtStartDate'));

		let date = $('#mtStartDate').val();
		let mbNum = $("[name=mtMbNum]").val();

		//공백을 제거해한 뒤에 개수를 세던지 한다.	
		let name = $.trim($("[name=mtName]").val());
		let intro = $.trim($("[name=mtIntro]").val());
		let supplies = $.trim($('#mtSupplies').val());
		
		let address = $.trim($('#cbAddress').val());
		let place = $.trim($('#cbPlace').val());

		$('[name=mtName]').val(name);
		$('[name=mtIntro]').val(intro);
		$('#mtSupplies').val(supplies);

		
		if (!address || address.length == 0) {
			alert("지도에서 마커를 클릭해주세요");
			return false;
		}
		
		if (!place || place.length == 0) {
			alert("지도에서 마커를 클릭해주세요");
			return false;
		}
		
		
		if (!name || name.length > 30) {
			alert("만남명을 다시 입력해주세요.");
			return false;
		}

		if (!date) {
			alert("만남날짜를 입력해주세요.");
			return false;
		}

		if (!mbnum || mbnum < 1) {
			alert("만남인원을 다시 입력해주세요.");
			return false;
		}

		/*값이 없어도 되지만, 길이제한은 둔다.*/
		if (supplies.length > 50) {
			alert("만남 준비물이 너무 깁니다.");
			return false;
		}

		/*값이 없어도 되지만, 길이제한은 둔다.*/
		if (intro.length > 100) {
			alert("만남소개가 너무 깁니다.");
			return false;
		}

		return true;
	}
</script>




<%@include file="../includes/footer.jsp"%>




