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

/* 파일 업로드 블로그 style */
.inputArea {margin:10px 0px;}
select {with:100px;}
label {display:inline-block; width:70px; padding:5px; }
label[for='gdsDes'] {display : block;}
input {width : 150px;}
textarea#gdsDes {width:400px; height:180px;}
.select_img img {margin:20px 0px;}
</style>

<link rel="stylesheet" type="text/css" href="/resources/css/kakaoMap.css">

<!--  번개 모임 개설 -->
<section id="wrap">

	<div class='weather'>
		<div class='City'></div>
	</div>


	<form action="/thunder/add" method="post" onsubmit="return inputCheck()" enctype="multipart/form-data">
		<div>
			<div>
				모임명<br>
				<!-- 30자 제한 -->
				<input type="text" required="required" name='cbName' size="50" style="border: 1px solid #ff9f40; padding: 3px 0px;">
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
				<!-- date 타입을 비동기적으로(실시간으로) 계속 찍어줘야 할듯
					ex) 1분차이로 현재의 시간이 과거가 될 수 도 있다. -->
				<!-- JS로 MIN과 MAX를 찍어주자 -->
				<input type="datetime-local" required="required" name='thunderDetailVO.cbDate' id='cbDate' style="border: 1px solid #ff9f40; padding: 3px 0px;">
			</div>
			<div>
				카테고리/분야<br> <select name="cbCategory" required="required" id='category' style="border: 1px solid #ff9f40; padding: 3px 0px;"></select>
			</div>

			<div>
				모임<br> <select name="cbSubcat" required="required" id="subcat" style="border: 1px solid #ff9f40; padding: 3px 0px;">
					<option value="모임 선택" selected>모임 선택
				</select>
			</div>
		</div>


		<div>
			<div>
				모임 인원<br> <input type="number" required="required" name='cbMbnum' min="1" max="1000000" style="border: 1px solid #ff9f40; padding: 3px 0px;">
			</div>

			<div>
				모임 마감기간<br> <input type="datetime-local" required="required" name='thunderDetailVO.cbAppPeriod' id='cbAppPeriod' style="border: 1px solid #ff9f40; padding: 3px 0px;">
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
				<input type="text" required="required" readonly="readonly" name='thunderDetailVO.cbAddress' id='cbAddress' style="border: 1px solid #ff9f40; padding: 3px 0px;">
			</div>
		</div>

		<div>
			<div>
				모임 장소 <br> <input type="text" required="required" readonly="readonly" name='thunderDetailVO.cbPlace' id='cbPlace' style="border: 1px solid #ff9f40; padding: 3px 0px;">
			</div>

			<div>
				모임 준비물<br> <input type="text" name='thunderDetailVO.cbSupplies' id='cbSupplies' size="50">
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
		<input type='hidden' name='cbCity'> <input type='hidden' name='cbDistrict'> <input type='hidden' name='thunderDetailVO.cbLocation' id='cbLocation'>


<div class="inputArea">
		<label for="gdsImg">이미지</label>
		 <input type="file" id="gdsImg" name="file" />
		<div class="select_img">
			<img src="" />
		</div>

		<script>
		/* 스크립트는 파일이 등록되면 현재화면에서 어떤 이미지인지 볼 수 있도록 해주는 역할 */
			$("#gdsImg").change(
					function() {
						if (this.files && this.files[0]) {
							var reader = new FileReader;
							reader.onload = function(data) {
								$(".select_img img").attr("src",
										data.target.result).width(500);
							}
							reader.readAsDataURL(this.files[0]);
						}
					});
		</script>
		<!-- 현재 프로젝트의 실제 경로를 표시합니다. 스프링 파일이 저장되는 워크스페이스와 다르므로, 파일을 저장할 때 실제 경로를 알아야합니다. -->
		<%=request.getRealPath("/") %>
	</div>
	
	
	</form>




	<!-- 카카오 맵 영역 -->
	<div class="map_wrap">
		<div id="map" style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>

		<div id="menu_wrap" class="bg_white">
			<div class="option">
				<div>

					<form role="form" onsubmit="searchPlaces(); return false;">
						모임 장소 : <input type="text" value="종각역" id="keyword" size="15" style="border: 1px solid #ff9f40; padding: 3px 0px;">
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
<script type="text/javascript" src="/resources/js/thunderAdd.js"></script>

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
				console.log("날짜 : " + today.format('YYYY-MM-DD'));
				tmp += '<div class="day">' + today.format('MM월 DD일') + '<div>';

				console.log("최고 기온 : " + resp.daily[idx].temp.max);
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
</script>




<%@include file="../includes/footer.jsp"%>




