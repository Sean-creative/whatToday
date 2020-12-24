
//문서가 모두 로드 되는 시점에 하는 것
$(function() {


	actionForm = $("#actionForm");

	$(".paginate_button a").on("click", function(e) {
		e.preventDefault();
		console.log('click');
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
/*	$(".pagination").change(function(e) {
		$("input[name='orderBy']").val(e.target.value);
		$("#actionForm").submit();
	});
*/
	$(".order_button a").on("click", function(e) {
		e.preventDefault();
		console.log('order_button click');
		actionForm.find("input[name='orderBy']").val($(this).attr("href"));
		actionForm.submit();
	});
	
	// 내부 JS에서 설정한 변수 값들 확인
	// 카테고리, 모임, 지역, 지역상세
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

});
// 문서 로드 END

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

// onclick 속성을 가져올 수 없어서,함수를 사용.
const linkToInfo = function(cbNum) {

	actionForm.append("<input type='hidden' name='cbNum' value='" + cbNum
			+ "'>");
	actionForm.attr("action", "/regular/info");
	actionForm.submit();
}

const inputCheck = function(){
	// 공백을 제거해한 뒤에 개수를 세던지 한다.
	let keyword = $.trim($("[name=keyword]").val());
	$('[name=keyword]').val(keyword);

	console.log(keyword.length);
	if (keyword.length > 30) {
		alert("키워드가 너무 깁니다 (30자 이하)");
		return false;
	}
}
