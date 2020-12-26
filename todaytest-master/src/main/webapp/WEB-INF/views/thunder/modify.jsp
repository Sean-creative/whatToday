<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!-- 작성자 : 김선우 -->
<link rel="stylesheet" type="text/css" href="/resources/css/kakaoMap.css">
<link rel="stylesheet" type="text/css" href="/resources/css/thunderAdd.css">
<%@include file="../includes/header.jsp"%>


<!--  번개 모임 수정 -->
<section>
	<div class="section_header" style="margin: 0 auto; text-align: center;">
		<span class="half">번개 모임 수정</span>
		<p>번개 모임을 수정해주세요</p>
	</div>
	<div id="container">


		<!-- ========중앙========== -->
		<div class="section_in" style="display: inline-block; overflow: hidden">
			<form role="form" action="/thunder/modify" id="modifyForm" method="post" enctype="multipart/form-data">
				<h6 class="form-stxt">*필수 입력사항&nbsp;&nbsp;</h6>
				<hr>
				<fieldset class="formContent">

					<div>
						<div style="display: inline-block; width: 300px;">
							<!-- 30자 제한 -->
							<label for="name" style="display: block;">모임명*</label>
							<input type="text" required="required" name='cbName' size="50" value='<c:out value="${clubVO.cbName}" />'>
						</div>

						<div style="display: inline-block; width: 300px;">
							<label for="request" class="class" style="display: block;">모임 인원*</label>
							<input type="number" required="required" name='cbMbnum' min="1" max="1000000" value='<c:out value="${clubVO.cbMbnum}"/>'>
						</div>
					</div>

					<div>
						<div style="display: inline-block; width: 300px;">
							<label for="email">카테고리/분야*</label>
							<select name="cbCategory" required="required" id='category'></select>
						</div>


						<div style="display: inline-block; width: 300px;">
							<label for="location">모임</label>
							<select name="cbSubcat" required="required" id="subcat">
								<option value="모임 선택" selected>모임 선택
							</select>
						</div>
					</div>

					<div>
						<div style="display: inline-block; width: 300px;">
							<!-- date 타입을 비동기적으로(실시간으로) 계속 찍어줘야 할듯
  					ex) 1분차이로 현재의 시간이 과거가 될 수 도 있다. -->
							<!-- JS로 MIN과 MAX를 찍어주자 -->
							<label for="hp">모임 날짜*</label>
							<input type="datetime-local" required="required" name='thunderDetailVO.cbDate' id='cbDate' value='<c:out value="${clubVO.thunderDetailVO.cbDate}" />'>
						</div>


						<div style="display: inline-block; width: 300px;">
							<label for="request" class="class">모임 마감기간*</label>
							<input type="datetime-local" required="required" name='thunderDetailVO.cbAppPeriod' id='cbAppPeriod' value='<c:out value="${clubVO.thunderDetailVO.cbAppPeriod}" />'>
						</div>
						
												
						<div class="header_in3">
							<ul class="header_weekday">
							</ul>
						</div>
					</div>




					<div>
						<div style="display: inline-block; width: 300px;">
							<label for="request" class="class">모임 지역*</label>
							<input type="text" required="required" readonly="readonly" name='thunderDetailVO.cbAddress' id='cbAddress' value='<c:out value="${clubVO.thunderDetailVO.cbAddress}" />'>
						</div>



						<div style="display: inline-block; width: 300px;">
							<label for="request" class="class">모임 장소 *</label>
							<input type="text" required="required" readonly="readonly" name='thunderDetailVO.cbPlace' id='cbPlace' value='<c:out value="${clubVO.thunderDetailVO.cbPlace}" />'>
						</div>
					</div>



					<div id="hash">

						<div style="display: inline-block; width: 300px;">
							<label for="request" class="class" style="display: block;">해시태그</label>
							<input type="hidden" value="" name="cbHashtag" id="rdTag" value='<c:out value="${clubVO.cbHashtag}" />' />
							<input type="text" id="tag" size="7" value="#" />
							<ul id="tag-list"></ul>
						</div>


						<div style="display: inline-block; width: 300px;">
							<label for="request" class="class" style="display: block;">한줄소개</label>
							<input type="text" name='thunderDetailVO.cbIntro' id='cbIntro' size="50" value='<c:out value="${clubVO.thunderDetailVO.cbIntro}" />'>
						</div>

					</div>


					<div class="request">
						<label for="request" class="class">사진 등록</label>
						<div class="select_img">
							<img class="thumbImg" src="${clubVO.cbThumbImg}" /> <br>
							<input type="file" id="gdsImg" name="file" />
						</div>
					</div>



				</fieldset>


				<hr>

				<fieldset class="agreebox">



					<div class="btn_faq">
						<button type="submit" data-oper='modify' class="btn-default">수정하기</button>
						<button type="submit" data-oper='remove' class="btn-default">삭제하기</button>
						<button type="submit" data-oper='list' class="btn-default">돌아가기</button>
					</div>
				</fieldset>





				<input type='hidden' id='cbNum' name='cbNum' value='<c:out value="${clubVO.cbNum}"/>'>
				<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
				<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
				<input type='hidden' name='category' value='<c:out value="${cri.category}"/>'>
				<input type='hidden' name='subclass' value='<c:out value="${cri.subclass}"/>'>
				<input type='hidden' name='city' value='<c:out value="${cri.city}"/>'>
				<input type='hidden' name='district' value='<c:out value="${cri.district}"/>'>
				<input type='hidden' name='searchBy' value='<c:out value="${cri.searchBy}"/>'>
				<input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>

				<!-- 사진 첨부 안했을 시 사용해야함 -->
				<input type='hidden' name='cbFile' value='<c:out value="${clubVO.cbFile}"/>'>
				<input type='hidden' name='cbThumbImg' value='<c:out value="${clubVO.cbThumbImg}"/>'>

				<!-- 지역 이름 정도만 컨트롤러에 보낸다. -->
				<input type='hidden' name='cbCity' value='<c:out value="${clubVO.cbCity}"/>'>
				<input type='hidden' name='cbDistrict' value='<c:out value="${clubVO.cbDistrict}"/>'>

				<input type='hidden' name='thunderDetailVO.cbLatitude' id='cbLatitude' value='<c:out value="${clubVO.thunderDetailVO.cbLatitude}"/>'>
				<input type='hidden' name='thunderDetailVO.cbLongitude' id='cbLongitude' value='<c:out value="${clubVO.thunderDetailVO.cbLongitude}"/>'>

				<!-- 업데이트가 되어있어야 하기때문에, mapper.xml의 update에 있는 속성은 전달해야함-->
				<input type='hidden' name='cbCurMbnum' value='<c:out value="${clubVO.cbCurMbnum}"/>'>
				<%-- <input type='hidden' name='cbShutDate' value='<c:out value="${clubVO.cbShutDate}"/>'  id='cbDate'> --%>
			</form>

		</div>
		<!-- 중앙 끝  -->





		<!-- ========오른쪽========== -->
		<div style="display: inline-block; background-color: red; width: 700px; height: 1100px; margin-top: 75px; margin-left: 40px;">

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



<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- 렌더링을 거의 마치고 JS를 해석 할 것  -->
<script type="text/javascript" src="/resources/js/thunderModify.js"></script>

<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e19ea28cff4b871b68b2fabda7855cab&libraries=services,clusterer,drawing"></script>

<script type="text/javascript" src="/resources/js/kakaoMap.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>


<script>
	/* 날씨관련 */
	let city = 'Seoul';
	// var apiURI =
	// "http://api.openweathermap.org/data/2.5/weather?q="+city+"&appid="+"dfb19fd20ff326431f940b75f34778da";
	var apiURI = "https://api.openweathermap.org/data/2.5/onecall?lat=37.537623499999995&lon=127.1580072&exclude=current,minutely,hourly,alerts&appid=dfb19fd20ff326431f940b75f34778da&lang=kr&units=metric";
	$
			.ajax({
				url : apiURI,
				dataType : "json",
				type : "GET",
				async : "false",
				success : function(resp) {
					console.log("도시 이름 : " + resp.timezone.split('/')[1]);
					// $('.City').append(resp.timezone.split('/')[1]);

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

													//사용자가 갑자기 엔터같은걸 누르면 특수문자가 들어갈 수 있으므로 한번 더 써줌, #은 제외
													var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-+<>@\$%&\\\=\(\'\"]/gi;

													// test() ㅡ 찾는 문자열이 들어있는지 확인
													if (regExp.test(tagValue)) {
														tagValue = tagValue
																.replace(
																		regExp,
																		""); // 찾은 특수 문자를 제거													
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

						//초기에 로딩이 되면 해시태그 데이터를 넣어준다!
						let stringHash = '${clubVO.cbHashtag}';
						let arrayHash = stringHash.split(',');
						for ( let i in arrayHash) {
							if (arrayHash[i] != "") {
								$("#tag-list")
										.append(
												"<li class='tag-item'>"
														+ arrayHash[i]
														+ "<span class='del-btn' idx='" + counter + "'>x</span></li>");
								addTag(arrayHash[i]);
							}
						}

						// Modify, Remove, List 중 버튼을 누른다면,
						let formObj = $("#modifyForm");

						$('.btn-default').on(
								"click",
								function(e) {
									e.preventDefault();

									let operation = $(this).data("oper");

									console.log(operation);

									if (operation === 'remove') {
										alert('삭제되었습니다');
										formObj.attr("action",
												"/thunder/remove");

									} else if (operation === 'list') {
										// move to list
										formObj.attr("action", "/thunder/list")
												.attr("method", "get");
									}
									// Modify 라고 한다면
									else {
										if (inputCheck()) {
											var value = marginTag(); // return array
											$("#rdTag").val(value);
											console.log("true");
										} else {
											console.log("false");
											return;
										}
									}
									formObj.submit();
								});

					})
</script>


<script type="text/javascript">
	/* 외부 JS에서 JSTL이 적용되지 않아서, 내부스크립트의 var를 써서 해결 */
	var cg = '${clubVO.cbCategory}';
	var sc = '${clubVO.cbSubcat}';
	var ct = '${clubVO.cbCity}';
	var dt = '${clubVO.cbDistrict}';
</script>

<%@include file="../includes/footer.jsp"%>






