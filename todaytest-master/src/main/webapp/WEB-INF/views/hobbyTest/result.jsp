<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="/resources/css/hobbyTest/testBackImg.css">
	<link rel="stylesheet" href="/resources/css/hobbyTest/testSlides.css">
    <title>취미 분석 테스트 결과</title>
</head>
<body>

<div class="bg-image"></div>
<div class="bg-text">
    <h1>취미 분석 테스트</h1>
    <p>당신의 취미를 찾아드립니다.</p><br><br>
    <div id = "testResult">
        <div><div class = "result" id="sub0"></div><p>${testReuslt0.subclass}</p></div>
        <div><div class = "result" id="sub1"></div><p>${testReuslt1.subclass}</p></div>
        <div><div class = "result" id="sub2"></div><p>${testReuslt2.subclass}</p></div>
    </div>
</div>

<script src="http://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript">
var img;

let results = document.getElementsByName("result");

let sub0 = "${testReuslt0.subclass}";
let cat0 = "${testReuslt0.category}";

let sub1 = "${testReuslt1.subclass}";
let cat1 = "${testReuslt1.category}";

let sub2 = "${testReuslt2.subclass}";
let cat2 = "${testReuslt2.category}";
	
let r0 = document.getElementById("sub0");
resultImg(sub0);
r0.style.backgroundImage = "url('" + img + "')";
r0.setAttribute('OnClick',"location.href='http://localhost:8088/regular/list?category=" + cat0 + "&subclass=" + sub0 + "'");

let r1 = document.getElementById("sub1");
resultImg(sub1);
r1.style.backgroundImage = "url('" + img + "')";
r1.setAttribute('OnClick',"location.href='http://localhost:8088/regular/list?category=" + cat1 + "&subclass=" + sub1 + "'");

let r2 = document.getElementById("sub2");
resultImg(sub2);
r2.style.backgroundImage = "url('" + img + "')";
r2.setAttribute('OnClick',"location.href='http://localhost:8088/regular/list?category=" + cat2 + "&subclass=" + sub2 + "'");


function resultImg(sub){
	switch (sub) {
	case "등산":
		img = "/resources/img/subclass/hiking.jpg";
		break;
	case "산책/트래킹":
		img = "/resources/img/subclass/tracking.jpg";
		break;
	case "캠핑/백패킹":
		img ="/resources/img/subclass/camping.jpg";
		break;
	case "낚시":
		img = "/resources/img/subclass/fishing.jpg";
		break;
		
	case "뮤지컬/오페라":
		img = "/resources/img/subclass/musical.jpg";
		break;
	case "공연/연극":
		img = "/resources/img/subclass/performance.jpg";
		break;
	case "전시회":
		img = "/resources/img/subclass/exhibition.jpg";
		break;
	case "파티/페스티벌":
		img = "/resources/img/subclass/festival.jpg";
		break;
		
	case "자전거":
		img = "/resources/img/subclass/bicycle.jpg";
		break;
	case "배드민턴":
		img = "/resources/img/subclass/badminton.jpg";
		break;
	case "볼링":
		img = "/resources/img/subclass/bowling.jpg";
		break;
	case "헬스/크로스핏":
		img = "/resources/img/subclass/fitness.jpg";
		break;
	case "탁구":
		img = "/resources/img/subclass/pingpong.jpg";
		break;
	case "당구/포켓볼":
		img = "/resources/img/subclass/pocketball.jpg";
		break;
	case "축구/풋살":
		img = "/resources/img/subclass/soccer.jpg";
		break;
	case "농구":
		img = "/resources/img/subclass/basketball.jpg";
		break;
	case "야구":
		img = "/resources/img/subclass/baseball.jpg";
		break;
	case "스케이트/인라인":
		img = "/resources/img/subclass/skate.jpg";
		break;
		
	case "노래/보컬":
		img = "/resources/img/subclass/sing.jpg";
		break;
	case "기타/베이스":
		img = "/resources/img/subclass/guitar.jpg";
		break;
	case "피아노":
		img = "/resources/img/subclass/piano.jpg";
		break;
	case "랩/힙합/DJ":
		img = "/resources/img/subclass/hiphop.jpg";
		break;
	case "클래식":
		img = "/resources/img/subclass/classic.jpg";
		break;
		
	case "영어":
		img = "/resources/img/subclass/english.jpg";
		break;
	case "일본어":
		img = "/resources/img/subclass/japanese.jpg";
		break;
	case "중국어":
		img = "/resources/img/subclass/chinese.jpg";
		break;
	case "프랑스어":
		img = "/resources/img/subclass/french.jpg";
		break;
	case "스페인어":
		img = "/resources/img/subclass/spanish.jpg";
		break;
	case "러시아어":
		img = "/resources/img/subclass/russia.jpg";
		break;
		
	case "다트":
		img = "/resources/img/subclass/dart.jpg";
		break;
	case "보드게임":
		img = "/resources/img/subclass/boardGame.jpg";
		break;
	case "온라인게임":
		img = "/resources/img/subclass/onlineGame.jpg";
		break;
	case "마술":
		img = "/resources/img/subclass/magic.jpg";
		break;
	case "바둑":
		img = "/resources/img/subclass/goGame.jpg";
		break;
		
	default:
		break;
	}
}
</script>
</body>
</html>
