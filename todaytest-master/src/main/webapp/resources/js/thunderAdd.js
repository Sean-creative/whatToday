//문서가 모두 로드 되는 시점에 하는 것
$(function() {

	const categoryArr = [ '관심분야 선택', '아웃도어/여행', '문화/공연/축제', '운동/스포츠', '음악/악기',
			'외국/언어', '게임/오락', '기타' ];
	for (let i = 0; i < categoryArr.length; i++) {
		document.getElementById("category")[i] = new Option(categoryArr[i],
				categoryArr[i]);
	}

	$('#category').change(function() {
		cate(this, $("#subcat"));
	});

	$('#city').change(function() {
		region(this, $("#district"));
	});

	// ** 모임 날짜와 모임 마감기간 정의 **
	// 모임 마감기간은 모임 날짜일보다 이전이어야 한다.
	// -- 모임 날짜를 클릭 했을 때, 모임 마감기간의 MAX가 설정 되어야 한다.
	// -- change로 해결해야 할듯
	// 모임 마감기간과 모임 날짜일 모두 MIN, MAX는 일주일 차이만 나야 한다. (구현완료)
	// 실시간으로 현재시간이 업데이트가 되면서, MIN이 달라져야 한다 (어려움)
	// 번개만들기를 클릭했을 때 다시 한번 현재시간을 업데이트 하면서 날짜를 체크해야 한다.

	dating($("#cbDate"), $("#cbAppPeriod"));

	$('#cbDate').change(function() {
		dating(this, $("#cbAppPeriod"));
	});

	/* 스크립트는 파일이 등록되면 현재화면에서 어떤 이미지인지 볼 수 있도록 해주는 역할 */
	$("#gdsImg").change(
			function() {
				if (this.files && this.files[0]) {
					var reader = new FileReader;
					reader.onload = function(data) {
						$(".select_img img").attr("src", data.target.result)
								.width(200).height(144);
					}
					reader.readAsDataURL(this.files[0]);
				}
			});






	/* 해시태그 관련 */
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
	// form에 넘기기 전에 inputCheck하고 해시태그 값을 String 형태로 보낸다.
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
	$("#tag").keyup(function(e) {
		let text = $(this).val();

		if (text.length == 0) {
			$(this).val("#");
		}

		// #은 제외
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
						if (e.key === "Enter" || e.keyCode == 32
								|| e.keyCode == 35) {

							if (maxHash >= 5) {
								alert("5개가 최대입니다.");
								self.val("#");
							} else {
								var tagValue = self.val(); // 값 가져오기
								console.log(tagValue);

								// 사용자가 갑자기 엔터같은걸 누르면 특수문자가 들어갈 수 있으므로 한번 더 써줌,
								// #은 제외
								var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-+<>@\$%&\\\=\(\'\"]/gi;

								// test() ㅡ 찾는 문자열이 들어있는지 확인
								if (regExp.test(tagValue)) {
									tagValue = tagValue.replace(regExp, ""); // 찾은
									// 특수
									// 문자를
									// 제거
								}

								// 값이 없으면 동작 안함, '#'만 실수로 들어가도 동작 안함
								if (tagValue !== "" && tagValue !== "#") {

									// 같은 태그가 있는지 검사한다. 있다면 해당값이 array 로 return
									// 된다.
									var result = Object.values(tag).filter(
											function(word) {
												return word === tagValue;
											})

									// 태그 중복 검사
									if (result.length == 0) {
										$("#tag-list")
												.append(
														"<li class='tag-item'>"
																+ tagValue
																+ "<span class='del-btn' idx='"
																+ counter
																+ "'>x</span></li>");
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

}); // end load

const cate = function(o, d) {

	// key, map 버전으로 한 걸루
	// AJAX 사용
	const outdoor = [ "모임 선택", "등산", "산책/트래킹", "캠핑/백패킹", "낚시", "기타" ];
	const culture = [ "모임 선택", "뮤지컬/오페라", "공연/연극", "전시회", "파티/페스티벌", "기타" ];
	const sports = [ "모임 선택", "자전거", "배드민턴", "볼링", "헬스/크로스핏", "탁구", "당구/포켓볼",
			"축구/풋살", "농구", "야구", "스케이트/인라인", "기타" ];
	const music = [ "모임 선택", "노래/보컬", "기타/베이스", "피아노", "랩/힙합DJ", "클래식", "기타" ];
	const language = [ "모임 선택", "영어", "일본어", "중국어", "프랑스어", "스페인어", "러시아어",
			"기타" ];
	const game = [ "모임 선택", "다트", "보드게임", "온라인게임", "마술", "바둑", "기타" ];
	const etc = [ "전체" ];

	let detailCate;

	d.empty();

	// change(function(){$( ':selected', o).val() => this }
	if ($(':selected', o).val() == "아웃도어/여행") {
		detailCate = outdoor;
	} else if ($(':selected', o).val() == "문화/공연/축제") {
		detailCate = culture;
	} else if ($(':selected', o).val() == "운동/스포츠") {
		detailCate = sports;
	} else if ($(':selected', o).val() == "음악/악기") {
		detailCate = music;
	} else if ($(':selected', o).val() == "외국/언어") {
		detailCate = language;
	} else if ($(':selected', o).val() == "게임/오락") {
		detailCate = game;
	} else if ($(':selected', o).val() == "기타") {
		detailCate = etc;
	} else {
		// 다시 '관심분야 선택'을 누르면 리턴
		let option = $("<option value='모임 선택'>모임 선택</option>");
		d.append(option);
		return;
	}

	for (let i = 0; i < detailCate.length; i++) {
		let option = $("<option value='" + detailCate[i] + "'>" + detailCate[i]
				+ "</option>");
		d.append(option);
	}
}

// '번개만들기'를 클릭 했을 때 이 함수가 호출되면서, 지속적으로 MIN을 현재 시간으로 바꿔주어야 한다. (Value는 냅둬야함)
const dating = function(o, d) {

	// toSOSString()을 이용하기 위해서 사용
	// getTimezoneOffset()은 현재 시간과의 차이를 분 단위로 반환한다.
	const offset = new Date().getTimezoneOffset() * 60000;
	const today = new Date(Date.now() - offset);

	// toISOString()에서 리턴하는 'yyyy-MM-ddThh:mm:ss.sssZ'을 슬라이싱함
	let nowDate = today.toISOString().slice(0, 16);
	/*
	 * console.log(nowDate); console.log(today.getDate());
	 */

	if ($(o).val()) {
		// 값을 입력한 후 일 때 Value는 냅둬야함

	} else if (!($(o).val())) {
		// date의 값이 아무것도 없을 때 (초기 설정일 때)는 초기 설정을 해준다
		// 초기 설정

		$('#cbDate').val(nowDate);
		$('#cbAppPeriod').val(nowDate);
	}
	// 현재시간으로 부터 일주일 더해준 것이 maxDay
	today.setDate(today.getDate() + 7);
	let maxDay = today.toISOString().slice(0, 16);
	$("#cbDate").attr('min', nowDate);
	$("#cbDate").attr('max', maxDay);

	$("#cbAppPeriod").attr('min', nowDate);
	// 모임 날짜를 클릭 했을 때, 모임 마감기간의 MAX가 설정 되어야 한다.
	$(d).attr('max', $(o).val());

}

const inputCheck = function() {

	// 번개만들기를 클릭 했을 때, 날짜를 한번 더 업데이트 해준다음에 검사한다.
	dating($('#cbDate'), $('#cbAppPeriod'));

	let date = $('#cbDate').val();
	let category = $("select[name=cbCategory]").val();
	let subcat = $("[name=cbSubcat]").val();
	let mbnum = $("[name=cbMbnum]").val();
	let appPeriod = $('#cbAppPeriod').val();
	let city = $("[name=cbCity]").val();
	let district = $("[name=cbDistrict]").val();

	// 공백을 제거해한 뒤에 개수를 세던지 한다.
	let clubname = $.trim($("[name=cbName]").val());
	let hashtag = $.trim($("[name=cbHashtag]").val());
	let intro = $.trim($("[name=cbIntro]").val());
	let place = $.trim($('#cbPlace').val());
	let supplies = $.trim($('#cbSupplies').val());

	$('[name=cbName]').val(clubname);
	$('[name=cbHashtag]').val(hashtag);
	$('[name=cbIntro]').val(intro);
	$('#cbPlace').val(place);
	$('#cbSupplies').val(supplies);

	if (!clubname || clubname.length > 30) {
		alert("모임명을 다시 입력해주세요.");
		return false;
	}

	if (!date) {
		alert("모임날짜를 입력해주세요.");
		return false;
	}

	if (category === '관심분야 선택') {
		alert("카테고리를 입력해주세요.");
		return false;
	}

	if (subcat === '모임 선택') {
		alert("모임을  입력해주세요.");
		return false;
	}

	if (!mbnum || mbnum < 1) {
		alert("모임인원을 다시 입력해주세요.");
		return false;
	}

	if (!appPeriod) {
		alert("모임 신청기간 다시 입력해주세요.");
		return false;
	}

	/* 값이 없어도 되지만, 길이제한은 둔다. */
	if (hashtag.length > 30) {
		alert("해시태그를 다시 입력해주세요.");
		return false;
	}

	if (city === '지역 선택') {
		alert("지역을  입력해주세요.");
		return false;
	}

	if (district === '세부지역 선택') {
		alert("세부지역을  입력해주세요.");
		return false;
	}

	if (!place || place.length > 30) {
		alert("모임장소를 다시 입력해주세요.");
		return false;
	}

	/* 값이 없어도 되지만, 길이제한은 둔다. */
	if (supplies.length > 50) {
		alert("모임 준비물을 다시 입력해주세요.");
		return false;
	}

	/* 값이 없어도 되지만, 길이제한은 둔다. */
	if (intro.length > 300) {
		alert("모임소개를 다시 입력해주세요.");
		return false;
	}

	return true;
}
