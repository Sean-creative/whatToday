
//문서가 모두 로드 되는 시점에 하는 것
$(function() {

	// 내부 JS에서 설정한 변수 값들 확인
	console.log(cg, sc, ct, dt);

	// 수정하려고 하는 모임의 카테고리와 모임을 처음부터 보여줘야 한다.
	// 해당 모임의 카테고리를 보여주면 모임도 자동으로 바꿔야 한다.
	// 초기 카테고리 설정!!
	const categoryArr = [ '관심분야 선택', '아웃도어/여행', '문화/공연/축제', '운동/스포츠', '음악/악기',
			'외국/언어', '게임/오락', '기타' ];

	for (let i = 0; i < categoryArr.length; i++) {

		// 기존에 등록한 데이터(cg)와 일치하면 selected를 준다.
		if (cg == (categoryArr[i])) {
			// 하나의 카테고리가 셀렉트가 되었을 때
			document.getElementById("category")[i] = new Option(categoryArr[i],
					categoryArr[i], true, true);
		} else {
			document.getElementById("category")[i] = new Option(categoryArr[i],
					categoryArr[i]);
		}
	}

	// 카테고리 설정이 끝나면, 모임 설정도 다시 해준다.
	cate($("#category"), $("#subcat"));

	// 아래의 sc(subCat)는 변수이다.
	// 값이 'sc'인 옵션에게 selected를 준다.
	$("#subcat option[value='" + sc + "']").attr('selected', 'selected');

	dating($("#cbDate"), $("#cbAppPeriod"));

	$('#cbDate').change(function() {
		dating(this, $("#cbAppPeriod"));
	});

	// 초기 지역 설정!!
	const cityArr = [ "지역 선택", "서울특별시", "경기도" ];

	for (let j = 0; j < cityArr.length; j++) {

		// 기존에 등록한 데이터(ct)와 일치하면 selected를 준다.
		if (ct == (cityArr[j])) {
			// 하나의 지역이 셀렉트가 되었을 때
			document.getElementById("city")[j] = new Option(cityArr[j],
					cityArr[j], true, true);
		} else {
			document.getElementById("city")[j] = new Option(cityArr[j],
					cityArr[j]);
		}
	}

	// 지역 설정이 끝나면, 세부지역 설정도 다시 해준다.
	region($("#city"), $("#district"));

	// 아래의 dt(subCat)는 변수이다.
	// 값이 'dt'인 옵션에게 selected를 준다.
	$("#district option[value='" + dt + "']").attr('selected', 'selected');

	// 관심취미 고를 때
	$('#category').change(function() {
		cate(this, $("#subcat"));
	});

	// 관심지역 고를 때
	$('#city').change(function() {
		region(this, $("#district"));
	});

	// Modify, Remove, List 중 버튼을 누른다면,
	let formObj = $("form");

	$('button').on("click", function(e) {
		e.preventDefault();

		let operation = $(this).data("oper");

		console.log(operation);

		if (operation === 'remove') {
			alert('삭제되었습니다');
			formObj.attr("action", "/thunder/remove");

		} else if (operation === 'list') {
			// move to list
			formObj.attr("action", "/thunder/list").attr("method", "get");

			let pageNumTag = $("input[name='pageNum']").clone();
			let amountTag = $("input[name = 'amount']").clone();

			let categoryTag = $("input[name = 'category']").clone();
			let subclassTag = $("input[name = 'subclass']").clone();
			let cityTag = $("input[name = 'city']").clone();
			let districtTag = $("input[name = 'district']").clone();
			let keywordTag = $("input[name = 'keyword']").clone();

			formObj.empty();

			formObj.append(pageNumTag);
			formObj.append(amountTag);

			formObj.append(categoryTag);
			formObj.append(subclassTag);
			formObj.append(cityTag);
			formObj.append(districtTag);
			formObj.append(keywordTag);

		}
		// Modify 라고 한다면
		else {
			if (!inputCheck()) {
				return;
			}
		}
		formObj.submit();
	});
});

const cate = function(o, d) {

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

const region = function(o, d) {

	const seoul = [ "세부지역 선택", "강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구",
			"금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구",
			"성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구" ];

	const gyeonggi = [ "세부지역 선택", "고양시", "과천시", "광명시", "광주시", "구리시", "군포시",
			"김포시", "남양주시", "동두천시", "부천시", "성남시", "수원시", "시흥시", "안산시", "안성시",
			"안양시", "양주시", "여주시", "오산시", "용인시", "의왕시", "의정부시", "이천시", "파주시",
			"평택시", "포천시", "하남시", "화성시", "가평군", "양평군", "연천군" ];

	let district;

	d.empty();

	// change(function(){$( ':selected', o).val() => this }
	if ($(':selected', o).val() == "서울특별시") {

		district = seoul;
	} else if ($(':selected', o).val() == "경기도") {

		district = gyeonggi;
	} else {

		// 다시 '시/도 선택'을 누르면 리턴
		let option = $("<option value='세부지역 선택'> 세부지역 선택</option>");
		d.append(option);
		return;
	}

	for (let i = 0; i < district.length; i++) {
		let option = $("<option value='" + district[i] + "'>" + district[i]
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

	if ($(o).val()) {
		// 값을 입력한 후 일 때 Value는 냅둬야함
		console.log("값이 있다.");

	} else if (!($(o).val())) {
		// date의 값이 아무것도 없을 때 (초기 설정일 때)는 초기 설정을 해준다
		// 초기 설정
		console.log("값이 없다.");

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

const inputCheck = function(){

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

	if (!mbnum || mbnum < 0) {
		alert("모임인원을 다시 입력해주세요.");
		return false;
	}

	if (!appPeriod) {
		alert("모임 신청기간 다시 입력해주세요.");
		return false;
	}

	if (!hashtag || hashtag.length > 30) {
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

	if (!supplies || supplies.length > 50) {
		alert("모임 준비물을 다시 입력해주세요.");
		return false;
	}
	if (!intro || intro.length >= 300) {
		alert("모임소개를 다시 입력해주세요.");
		return false;
	}

	alert('수정되었습니다.');

	return true;
}