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
.inputArea {
	margin: 10px 0px;
}

select {
	with: 100px;
}

label {
	display: inline-block;
	width: 70px;
	padding: 5px;
}

label[for='gdsDes'] {
	display: block;
}

input {
	width: 150px;
}

textarea#gdsDes {
	width: 400px;
	height: 180px;
}

.select_img img {
	margin: 20px 0px;
}

/* 해시태그 구현 */
* {
	margin: 0;
	padding: 0;
	list-style: none;
}

ul {
	padding: 16px 0;
}

ul li {
	display: inline-block;
	margin: 0 5px;
	font-size: 14px;
	letter-spacing: -.5px;
}

form {
	padding-top: 16px;
}

ul li.tag-item {
	padding: 4px 8px;
	background-color: orange;
	color: white;
}

.tag-item:hover {
	background-color: #262626;
	color: #fff;
}

.del-btn {
	font-size: 12px;
	font-weight: bold;
	cursor: pointer;
	margin-left: 8px;
}

.thumbImg {
	width: 200px;
	height: auto;
}
</style>

<link rel="stylesheet" type="text/css" href="/resources/css/kakaoMap.css">

<!--  번개 모임 개설 -->
<section id="wrap">

	<div class='weather'>
		<div class='City'></div>
	</div>

	<!-- onsubmit="return inputCheck()" -->
	<form action="/thunder/add" method="post" id="tag-form" enctype="multipart/form-data">
		<div>
			<div>
				모임명<br>
				<!-- 30자 제한 -->
				<input type="text" required="required" name='cbName' size="50" style="border: 1px solid #ff9f40; padding: 3px 0px;">
			</div>

		</div>

		<div class="inputArea" style="float: left; margin-right: 50px">

			<div class="select_img" style="margin: 2px 0px">
				<img class="thumbImg" src="/resources/img/logo.png" style="margin: 0px;" /> <br>
				<!-- <label for="gdsImg" >이미지 선택</label> -->
				<input type="file" id="gdsImg" name="file" style="width: 200px;" />
			</div>

			<script>
				/* 스크립트는 파일이 등록되면 현재화면에서 어떤 이미지인지 볼 수 있도록 해주는 역할 */
				$("#gdsImg").change(
						function() {
							if (this.files && this.files[0]) {
								var reader = new FileReader;
								reader.onload = function(data) {
									$(".select_img img").attr("src",
											data.target.result).width(200)
											.height(144);
								}
								reader.readAsDataURL(this.files[0]);
							}
						});
			</script>
			<!-- 현재 프로젝트의 실제 경로를 표시합니다. 스프링 파일이 저장되는 워크스페이스와 다르므로, 파일을 저장할 때 실제 경로를 알아야합니다. -->
			<%-- <%=request.getRealPath("/")%> --%>
		</div>







		<div>
			<div>
				모임 날짜<br>
				<!-- date 타입을 비동기적으로(실시간으로) 계속 찍어줘야 할듯
					ex) 1분차이로 현재의 시간이 과거가 될 수 도 있다. -->
				<!-- JS로 MIN과 MAX를 찍어주자 -->
				<input type="datetime-local" required="required" name='thunderDetailVO.cbDate' id='cbDate' style="width: 200px; border: 1px solid #ff9f40; padding: 3px 0px;">
			</div>
			<div>
				카테고리/분야<br>
				<select name="cbCategory" required="required" id='category' style="border: 1px solid #ff9f40; padding: 3px 0px;"></select>
			</div>

			<div>
				모임<br>
				<select name="cbSubcat" required="required" id="subcat" style="border: 1px solid #ff9f40; padding: 3px 0px;">
					<option value="모임 선택" selected>모임 선택
				</select>
			</div>
		</div>


		<div>
			<div>
				모임 인원<br>
				<input type="number" required="required" name='cbMbnum' min="1" max="1000000" style="border: 1px solid #ff9f40; padding: 3px 0px;">
			</div>

			<div>
				모임 마감기간<br>
				<input type="datetime-local" required="required" name='thunderDetailVO.cbAppPeriod' id='cbAppPeriod' style="width: 200px; border: 1px solid #ff9f40; padding: 3px 0px;">
			</div>

			<div>
				해시태그<br>
				<input type="hidden" value="" name="cbHashtag" id="rdTag" />


				<div>
					<input type="text" id="tag" size="7" value="#" />
				</div>
				<ul id="tag-list"></ul>
			</div>
		</div>







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
				모임 장소 <br>
				<input type="text" required="required" readonly="readonly" name='thunderDetailVO.cbPlace' id='cbPlace' style="border: 1px solid #ff9f40; padding: 3px 0px;">
			</div>

			<div>
				모임 준비물<br>
				<input type="text" name='thunderDetailVO.cbSupplies' id='cbSupplies' size="50">
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

		<input type='hidden' name='thunderDetailVO.cbLatitude' id='cbLatitude'>
		<input type='hidden' name='thunderDetailVO.cbLongitude' id='cbLongitude'>





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

	$(document)
			.ready(
					function() {

						var tag = {};
						var counter = 0;
						var maxHash = 0;

						// 태그를 추가한다.
						function addTag(value) {
							tag[counter] = value; // 태그를 Object 안에 추가
							counter++; // counter 증가 삭제를 위한 del-btn 의 고유 id 가 된다.
							maxHash++;
						}

						// 최종적으로 서버에 넘길때 tag 안에 있는 값을 array type 으로 만들어서 넘긴다.
						function marginTag() {
							return Object.values(tag).filter(function(word) {
								return word !== "";
							});
						}

						// 서버에 넘기기
						$("#tag-form").on("submit", function(e) {
							var value = marginTag(); // return array
							$("#rdTag").val(value);

							if (inputCheck() == true) {
								alert('개설되었습니다.');
							} else {
								e.preventDefault();
							}
						});

						// 처음 부터 #이 달려있고
						// 엔터, 스페이스바 , # 을 누르면 -> #까지 해서 올라간다.
						// 5개까지 밖에 입력하지 못한다.
						$("#tag")
								.keyup(
										function(e) {
											let text = $(this).val();

											if (text.length == 0) {
												$(this).val("#");
											}

											//#은 제외
											var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-+<>@\$%&\\\=\(\'\"]/gi;

											// test() ㅡ 찾는 문자열이 들어있는지 확인
											if (regExp.test(text)) {
												text = text.replace(regExp, ""); // 찾은 특수 문자를 제거													
											}
											$(this).val(text);
										});

						$("#tag")
								.on(
										"keypress",
										function(e) {

											var self = $(this);

											// input 에 focus 되있을 때 엔터 및 스페이스바 입력시 구동
											if (e.key === "Enter"
													|| e.keyCode == 32
													|| e.keyCode == 35) {

												if (maxHash >= 5) {
													alert("5개가 최대입니다.");
													self.val("#");
												} else {
													var tagValue = self.val(); // 값 가져오기
													console.log(tagValue);

													//사용자가 갑자기 엔터같은걸 누르면 특수문자가 들어갈 수 있으므로 한번 더 써줌, #은 제외
													var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-+<>@\$%&\\\=\(\'\"]/gi;
													 													 
													// test() ㅡ 찾는 문자열이 들어있는지 확인
													if(regExp.test(tagValue)){													 
													tagValue = tagValue.replace(regExp, ""); // 찾은 특수 문자를 제거													
													}
													

													// 값이 없으면 동작 안함, '#'만 실수로 들어가도 동작 안함
													if (tagValue !== ""
															&& tagValue !== "#") {

														// 같은 태그가 있는지 검사한다. 있다면 해당값이 array 로 return 된다.
														var result = Object
																.values(tag)
																.filter(
																		function(
																				word) {
																			return word === tagValue;
																		})

														// 태그 중복 검사
														if (result.length == 0) {
															$("#tag-list")
																	.append(
																			"<li class='tag-item'>"
																					+ tagValue
																					+ "<span class='del-btn' idx='" + counter + "'>x</span></li>");
															addTag(tagValue);
															self.val("#");
														} else {
															alert("태그값이 중복됩니다.");
														}
													}
												}
												e.preventDefault(); // SpaceBar 시 빈공간이 생기지 않도록 방지

											}
										});

						// 삭제 버튼
						// 삭제 버튼은 비동기적 생성이므로 document 최초 생성시가 아닌 검색을 통해 이벤트를 구현시킨다.
						$(document).on("click", ".del-btn", function(e) {
							var index = $(this).attr("idx");
							tag[index] = "";
							$(this).parent().remove();
							maxHash--;
						});
					})
</script>




<%@include file="../includes/footer.jsp"%>




