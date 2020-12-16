<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- 작성자 : 김선우 -->

<%@include file="../includes/header.jsp"%>
<style>
.weather {
	display: flex;
	color: white;
}

.weather div {
	width: 100px;
	text-align: center;
}

.City {
	background-color: red;
}

.weatherContent {
	background-color: black;
	color: white;
}

.day {
	font-size: 0.938rem;
}

.Icon, .Temp {
	font-size: 1.375em;
}

.Icon {
	margin-right: 2px;
}
</style>

<link rel="stylesheet" type="text/css" href="/resources/css/kakaoMap.css">

<!--만남 개설 -->
<section id="wrap">

	<div class='weather'>
		<div class='City'></div>
	</div>
	
	<form action="/meeting/add" method="post" onsubmit="return inputCheck()">
		<div>
			<div>
				만남명<br>
				<!-- 30자 제한 -->
				<input type="text" required="required" name='mtName' size="50" style="border: 1px solid #ff9f40; padding: 3px 0px;">
			</div>

		</div>

		<div>
			<div>
				만남 날짜<br>
				<!-- date 타입을 비동기적으로(실시간으로) 계속 찍어줘야 할듯
					ex) 1분차이로 현재의 시간이 과거가 될 수 도 있다. -->
				<!-- JS로 MIN과 MAX를 찍어주자 -->
				<input type="datetime-local" required="required" name='mtStartDate' id='mtStartDate' style="width: 200px; border: 1px solid #ff9f40; padding: 3px 0px;">
			</div>
		</div>


		<div>
			<div>
				만남 인원<br>
				<input type="number" required="required" name='mtMbNum' min="1" max="1000000" style="border: 1px solid #ff9f40; padding: 3px 0px;">
			</div>
		</div>


		<div>
			<div>
				만남 지역 <br>
				<!-- 값이 '서울 종로구' 이런식으로 들어오는데,
                  1. js단에서  ','를 기준으로 값을 분리해주면 되겠다. -->
				<input type="text" required="required" readonly="readonly" name='mtAddress' id='cbAddress' style="border: 1px solid #ff9f40; padding: 3px 0px;">
			</div>
		</div>

		<div>
			<div>
				만남 장소 <br>
				<input type="text" required="required" readonly="readonly" name='mtPlace' id='cbPlace' style="border: 1px solid #ff9f40; padding: 3px 0px;">
			</div>

			<div>
				만남 준비물<br>
				<input type="text" name='mtSupplies' id='mtSupplies' size="50">
			</div>
		</div>

		<div>
			만남소개<br>
			<!-- 300자 제한 -->
			<textarea name='mtIntro' cols="100" rows="7" maxlength="300"></textarea>
		</div>

		<div style="margin-left: 470px">
			<button type="submit">만남만들기</button>
			<button type="reset" onclick="alert('리셋되었습니다.')">리셋 하기</button>
		</div>


		<!-- 모임 번호정도만 컨트롤러에 보낸다. -->		
		<input type="hidden" name="cbNum" value="<c:out value="${cbNum}" />" />
		<input type="hidden" name="cbName" value="${cbName}" />
				
	</form>




	<!-- 카카오 맵 영역 -->
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
	<!-- 카카오 맵 END -->





</section>

<!-- 렌더링을 거의 마치고 JS를 해석 할 것  -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e19ea28cff4b871b68b2fabda7855cab&libraries=services,clusterer,drawing"></script>

<script type="text/javascript" src="/resources/js/kakaoMap.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

<script>
	let city = 'Seoul';
	// var apiURI = "http://api.openweathermap.org/data/2.5/weather?q="+city+"&appid="+"dfb19fd20ff326431f940b75f34778da";
	var apiURI = "https://api.openweathermap.org/data/2.5/onecall?lat=37.537623499999995&lon=127.1580072&exclude=current,minutely,hourly,alerts&appid=dfb19fd20ff326431f940b75f34778da&lang=kr&units=metric";
	$.ajax({
		url : apiURI,
		dataType : "json",
		type : "GET",
		async : "false",
		success : function(resp) {
			console.log("도시 이름 : " + resp.timezone.split('/')[1]);
			$('.City').append(resp.timezone.split('/')[1]);

			for ( let idx in resp.daily) {
				let tmp = '<div class="weatherContent">';
				let days = new Date();
				days.setTime(resp.daily[idx].dt * 1000);
				const today = moment(days);
				tmp += '<div class="day">' + today.format('MM월 DD일') + '<div>';

				tmp += '<div class="Temp">'
						+ Math.floor(resp.daily[idx].temp.min) + '&ordm/'
						+ Math.floor(resp.daily[idx].temp.max) + '&ordm<div>';

				imgURL = "http://openweathermap.org/img/w/"
						+ resp.daily[idx].weather[0].icon + ".png";
				tmp += '<div class="Icon">' + "<img src="+imgURL+">" + '<div>';
				tmp += "</div>"

				$('.weather').append(tmp);
			}
		}
	})

	const inputCheck = function() {
		
		let date = $('#mtStartDate').val();		
		let mbNum = $("[name=mtMbNum]").val();				
		
		//공백을 제거해한 뒤에 개수를 세던지 한다.	
		let name = $.trim($("[name=mtName]").val());		
		let intro = $.trim($("[name=mtIntro]").val());	
		let supplies = $.trim($('#mtSupplies').val());

		$('[name=mtName]').val(name);		
		$('[name=mtIntro]').val(intro);	
		$('#mtSupplies').val(supplies);
		
		

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
		if (intro.length > 300) {
			alert("만남소개가 너무 깁니다.");
			return false;
		}

		return true;
	}
</script>




<%@include file="../includes/footer.jsp"%>




